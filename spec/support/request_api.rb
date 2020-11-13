module RequestAPI
  # responsável por fazer o parse das respostas que chegam em JSON para hash
  def body_json(symbolize_keys: false)
    # O response é um objeto do RSpec que contém os dados de uma resposta de um request que foi feito
    json = JSON.parse(response.body) # converter para Hash
    symbolize_keys ? json.deep_symbolize_keys : json
  rescue # equivalente ao catch
    return {} 
  end

  # responsável por retornar o cabeçalho de autenticação de um usuário
  # merge_with é um parâmetro que esperamos receber cabeçalhos adicionais 
  # que queiramos enviar junto com o cabeçalho de autenticação
  def auth_header(user = nil, merge_with: {})
    user ||= create(:user) # se não foi informado o user, então cria-se um
    auth = user.create_new_auth_token # create_new_auth_token é do Devise e retorna um auth_token
    header = auth.merge({ 'Content-Type' => 'application/json', 'Accept' => 'application/json' })
    header.merge merge_with
  end
end

#inclui este módulo dentro do RSpec para testes do tipo :request.
RSpec.configure do |config|
  config.include RequestAPI, type: :request
end

