module Authenticatable
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_user!
    # before_action indica que a função authenticate_user será chamada
    # sempre antes de entrar no controller que possuí este Concern.
    # authenticate_user é uma função do DeviseTokenAuth
  end
end

# Concern são arquivos que servem para externer algum controller.
# Neste exemplo, o Concer Authenticatable será utilizado tanto 
# nos controllers do admin como no storefront.