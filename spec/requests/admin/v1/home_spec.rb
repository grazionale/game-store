require "rails_helper"

describe "Home", type: :request do
  # Criando um usuário utilizando o método create do FactoryBot para chamar a factory user.
  # O let, que circunda este create, vai gerar um método interno a cada teste que poderemos 
  # acessar o usuário criado com a factory.
  let(:user) { create(:user) }

  it "tests home" do
    get '/admin/v1/home', headers: auth_header(user) # auth_header foi criado no request_api.rb
    expect(body_json).to eq({ 'message' => 'Uhul!' }) # body_json foi criado no request_api.rb
  end

  it "tests home" do
    get '/admin/v1/home', headers: auth_header(user)
    expect(response).to have_http_status(:ok)
  end
end
