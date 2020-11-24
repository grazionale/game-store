# a ideia desta service, é receber um model(que tenha o concern NameSearchable e Paginatable) e alguns parametros, 
# onde será possível executar a busca ordenada, paginação e filtro pelo atributo :name dos registros
module Admin  
  class ModelLoadingService
    def initialize(searchable_model, params = {})
      @searchable_model = searchable_model
      @params = params
      @params ||= {}
    end

    def call
      @searchable_model.search_by_name(@params.dig(:search, :name))
                       .order(@params[:order].to_h) 
                       .paginate(@params[:page].to_i, @params[:length].to_i)
    end    
  end
end

# o service é o PORO (Pure and Old Ruby Object), um objeto puro do Ruby

# dig é para acessar uma chave dentro do hash. Na linha 12, é acessado o atributo name, 
# dentro do hash search, que por sua vez, está dentro de params

# to_h = transforma um array para hash