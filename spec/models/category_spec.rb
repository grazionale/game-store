require 'rails_helper'

RSpec.describe Category, type: :model do
  # Este validate_presence_of é um matcher incluído pelo
  # Shoulda Matchers e o método is_expected também é do
  # Shoulda Matchers, mas utiliza o subject do RSpec.
  # O subject do RSpec nada mais é do que uma instância da
  # classe que estamos, que o RSpec sabe através
  # do describe que colocamos.
  it { is_expected.to validate_presence_of(:name) }

  # O validate_uniqueness_of também é um matcher do Shoulda Matchers
  # e é capaz de validar de um atributo está sendo validado para ser único.
  # Este matcher ainda tem a capacidade de verificar se a validação
  # é case insensitive, como fizemos agora
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }

  # Queremos uma associação has_many de Category para ProductCategory com remoção de 
  # dependentes. Ou seja, quando Category for removida, todos os registros 
  # ProductCategory associados a ela também serão. Além disso, estamos adicionando uma 
  # associação has_many direto com Product através da associação com ProductCategory
  it { is_expected.to have_many(:product_categories).dependent(:destroy) }
  it { is_expected.to have_many(:products).through(:product_categories) }

  # Estamos então chamando o concern 'name searchable concern' e passando como parâmetro o nome da factory
  it_behaves_like "name searchable concern", :category
  it_behaves_like "paginatable concern", :category
end
