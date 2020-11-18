module Admin::V1
  class ApiController < ApplicationController
    # chamaremos de ForbiddenAccess e é ela que vamos lançar quando o erro de acesso ocorrer
    class ForbiddenAccess < StandardError; end
    include Authenticatable # concerm criado para forçar que o usuário esteja autenticado
    
    # antes de toda chamada aos endpoints do admin que herdem de ApiController, será feito
    # uma verificação para saber se o usuário é admin
    before_action :restrict_access_for_admin!

    # toda vez que houver um erro(recusa) na classe ForbiddenAccess será executado esse bloco
    rescue_from ForbiddenAccess do 
      render_error(message: "Forbidden access", status: :forbidden)
    end

    def render_error(message: nil, fields: nil, status: :unprocessable_entity)
      errors = {}
      errors['fields'] = fields if fields.present?
      errors['message'] = message if message.present?
      render json: { errors: errors }, status: status
    end

    private

    def restrict_access_for_admin!
      # raise lança uma exception, no caso nossa classe ForbiddenAccess que herda de StandadError
      raise ForbiddenAccess unless current_user.admin?
    end
  end
end