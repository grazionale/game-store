require 'rails_helper'

RSpec.describe "Admin::V1::Categories", type: :request do
  let(:user) { create(:user) }

  context "GET /categories" do
    let(:url) { "/admin/v1/categories" }
    # ! significa bang, Precisamos fazer isso porque o let opera com lazy loading, ou seja, 
    # ele só carrega o conteúdo quando chamamos o método pela primeira vez. Precisamos utilizar 
    # o let! para categories porque nós precisamos que ele seja executado antes de fazermos o 
    # request, caso contrário não teremos dados retornados pelo endpoint.
    let!(:categories) { create_list(:category, 5) }

    it "returns all Categories" do
      get url, headers: auth_header(user)
      expect(body_json['categories']).to contain_exactly *categories.as_json(only: %i(id name))
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end  
  end
end
