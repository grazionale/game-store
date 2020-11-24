require "rails_helper"

# implementar um parâmetro call que vai receber dois parâmetros: um obrigatório 
# que vai ser o model onde queremos realizar a busca e outro opcional que são 
# os parâmetros da busca, que esperamos que sejam :order para a chave de ordenação, 
# page e length para paginação e seach[:name] para a busca por nome.
describe Admin::ModelLoadingService do
  context "when #call" do
    # a escolha de categories, foi apenas de exemplo, esse service será usado por quaquer model que quiser
    let!(:categories) { create_list(:category, 15) }

    context "when params are present" do
      let!(:search_categories) do
        categories = []
        15.times { |n| categories << create(:category, name: "Search #{n + 1}") }
        categories
      end
    
      let(:params) do
        { search: { name: "Search" }, order: { name: :desc }, page: 2, length: 4 }
      end

      it "returns right :length following pagination" do
        service = described_class.new(Category.all, params)
        result_categories = service.call
        expect(result_categories.count).to eq 4
      end   
      
      it "returns records following search, order and pagination" do
        search_categories.sort! { |a, b| b[:name] <=> a[:name] } # ordenando por desc
        service = described_class.new(Category.all, params)
        result_categories = service.call
        expected_categories = search_categories[4..7]
        expect(result_categories).to contain_exactly *expected_categories
      end    
    end

    context "when params are not present" do
      it "returns default :length pagination" do
        service = described_class.new(Category.all, nil)
        result_categories = service.call
        expect(result_categories.count).to eq 10 # por default, quando n há parametros, o length é 10
      end
    
      it "returns first 10 records" do
        service = described_class.new(Category.all, nil)
        result_categories = service.call
        expected_categories = categories[0..9]
        expect(result_categories).to contain_exactly *expected_categories
      end
    end
  end
end
