require 'rails_helper'

RSpec.describe "Admin V1 Categories as :client", type: :request do
  let(:user) { create(:user, profile: :client) }

  context "GET /categories" do
    let(:url) { "/admin/v1/categories" }
    let!(:categories) { create_list(:category, 5) }

    before(:each) { get url, headers: auth_header(user) } # antes de cada it é feito a request
    include_examples "forbidden access" # é o shared_examples que contém os testes para forbidden access
  end

  context "POST /categories" do
    let(:url) { "/admin/v1/categories" }

    before(:each) { get url, headers: auth_header(user) }
    include_examples "forbidden access"
  end

  context "PATCH /categories/:id" do
    let(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" }

    before(:each) { get url, headers: auth_header(user) }
    include_examples "forbidden access"
  end

  context "DELETE /categories/:id" do
    let!(:category) { create(:category) }
    let(:url) { "/admin/v1/categories/#{category.id}" } 

    before(:each) { get url, headers: auth_header(user) }
    include_examples "forbidden access"
  end

end