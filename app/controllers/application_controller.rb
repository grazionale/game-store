class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation])
  end
end

# if: :devise_controller? serve para carregar o código configure_permitted_parameters 
# somenete no devise_controller

# Por padrão, o devise aceita apenas email, password e 
# password_confirmation na criação de um novo usuário
# por isso, através da função configure_permitted_parameters
# definimos que ele também aceitará o campo name
