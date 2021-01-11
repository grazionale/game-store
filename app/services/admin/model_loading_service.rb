# a ideia desta service, é receber um model(que tenha o concern NameSearchable e Paginatable) e alguns parametros, 
# onde será possível executar a busca ordenada, paginação e filtro pelo atributo :name dos registros
module Admin  
  class ModelLoadingService
    attr_reader :records, :pagination
    
    def initialize(searchable_model, params = {})
      @searchable_model = searchable_model
      @params = params || {}
      @records = []
      @pagination = { page: @params[:page].to_i, length: @params[:length].to_i }
    end

    def call
      fix_pagination_values
      filtered = search_records(@searchable_model)
      @records = filtered.order(@params[:order].to_h).paginate(@pagination[:page], 
        @pagination[:length])
      
      total_pages = (filtered.count / @pagination[:length].to_f).ceil # ceil arredonda para cima

      @pagination.merge!(total: filtered.count, total_pages: total_pages)
    end 
    
    private 
    
    def fix_pagination_values
      @pagination[:page] = @searchable_model.model::DEFAULT_PAGE if @pagination[:page] <= 0
      @pagination[:length] = @searchable_model.model::MAX_PER_PAGE if @pagination[:length] <= 0
    end
    
    def search_records(searched)
      return searched unless @params.has_key?(:search)
      @params[:search].each do |key, value|
        searched = searched.like(key, value)
      end
      searched
    end
  end
end

# o service é o PORO (Pure and Old Ruby Object), um objeto puro do Ruby

# dig é para acessar uma chave dentro do hash. Na linha 12, é acessado o atributo name, 
# dentro do hash search, que por sua vez, está dentro de params

# to_h = transforma um array para hash