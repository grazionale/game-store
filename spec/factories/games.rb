FactoryBot.define do
  factory :game do
    mode { %i[pvp pve both].sample } # Equi
    release_date { '2020-06-01' }
    developer { Faker::Company.name }
    system_requirement
  end
end
# Estamos informando todos os campos do model Game. Repare também, no último item,
# que temos um system_requirement: quando chamamos desta forma, é um atralho que
# informa que existe uma associação deste model com SystemRequirement e que, quando
# Game for criado, essa associação deve existir, então ele também cria um
# SystemRequirement para associar.
# Para mode nós estamos pegando um valor aleatório entre "pvp", "pve" e "both"
