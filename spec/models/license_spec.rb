require 'rails_helper'

RSpec.describe License, type: :model do
  # por padrão, o rspec, utiliza a Classe para realizar os testes. Mas, há 
  # cenários que precisamos usar a Factory, por isso é usado o subject, para 
  # determinar que quem vai ser testado, vai ser a Factory e não apenas a Classe.
  # o motivo neste caso é que, license, tem uma FK para Game, e ao testar 
  # diretamente a Classe License, o game não vai existir, enquanto, ao testar
  # a factory License, definimos a criação do Game nela e vinculo da FK.
  subject { build(:license) }

  it { is_expected.to belong_to :game }
  it { is_expected.to validate_presence_of(:key) }
  # scoped_to faz que a validação de unicidade seja específica por :platform
  it { is_expected.to validate_uniqueness_of(:key).case_insensitive.scoped_to(:platform) }
  it { is_expected.to validate_presence_of(:platform) }
  it { is_expected.to define_enum_for(:platform).with_values({ steam: 1, battle_net: 2, origin: 3 }) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to define_enum_for(:status).with_values({ available: 1, in_use: 2, inactive: 3 }) }
end
