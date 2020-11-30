module Admin  
  class ProductSavingService
    class NotSavedProductError < StandardError; end

    attr_reader :product, :errors

    def initialize(params, product = nil)
      params = params.deep_symbolize_keys # transforma os params em simbolos
      @product_params = params.reject { |key| key == :productable_attributes } # removendo os atributos que seriam de productable e não de produto
      @productable_params = params[:productable_attributes] || {} # recebendo apenas os atributos de productable
      @errors = {}
      @product = product || Product.new
    end
    
    def call
      Product.transaction do
        @product.attributes = @product_params.reject { |key| key == :productable }
        build_productable
      ensure # O ensure será para forçar uma chamada ao método save!
        save!
      end
    end
    
    def build_productable
      # primeiro é verificado se existe o productable em produto (em caso de atualização),
      # se não existir, pegamos o productable dos parametros (Ex: game), transformamos em 
      # camelcase, ficando Game, chamamos o safe_constantize.new para iniciar como se fosse
      # uma classe
      @product.productable ||= @product_params[:productable].camelcase.safe_constantize.new
      @product.productable.attributes = @productable_params
    end

    def save!
      save_record!(@product.productable) if @product.productable.present?
      save_record!(@product)
      raise NotSavedProductError if @errors.present?
    rescue => e
      raise NotSavedProductError
    end

    def save_record!(record)
      record.save!
    rescue ActiveRecord::RecordInvalid
      @errors.merge!(record.errors.messages)
    end
  end
end