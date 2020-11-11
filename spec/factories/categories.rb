FactoryBot.define do
  # Com o sequence, cada vez que a factory for chamada dentro 
  # de um teste, o n vai receber um valor diferente. Ou seja, 
  # se criarmos duas categorias com ela, ele criará com o nome 
  # Category 1 e Category 2, sequencialmente. E isso é necessário
  # pois definimos que a category deve ter um nome único
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
  end
end
