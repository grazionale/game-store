require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { build(:product) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  it { is_expected.to validate_presence_of(:image) }
  it { is_expected.to belong_to :productable }
  it { is_expected.to define_enum_for(:status).with_values({ available: 1, unavailable: 2 }) }

  # Queremos uma associação has_many de Product para ProductCategory com remoção de 
  # dependentes. Ou seja, quando Product for removido, todos os registros 
  # ProductCategory associados a ele também serão. Além disso, estamos adicionando uma 
  # associação has_many direto com Category através da associação com ProductCategory
  it { is_expected.to have_many(:product_categories).dependent(:destroy) }
  it { is_expected.to have_many(:categories).through(:product_categories) }

  it_behaves_like "name searchable concern", :product
  it_behaves_like "paginatable concern", :product
end
