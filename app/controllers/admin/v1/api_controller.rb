module Admin::V1
  class ApiController < ApplicationController
    include Authenticatable # concerm criado para forçar que o usuário esteja autenticado

    def render_error(message: nil, fields: nil, status: :unprocessable_entity)
      errors = {}
      errors['fields'] = fields if fields.present?
      errors['message'] = message if message.present?
      render json: { errors: errors }, status: status
    end
  end
end