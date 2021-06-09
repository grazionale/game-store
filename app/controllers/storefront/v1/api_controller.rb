module Storefront::V1
  class ApiController < ApplicationController
    include Authenticatable # concerm criado para forçar que o usuário esteja autenticado

    include SimpleErrorRenderable
    self.simple_error_partial = "shared/simple_error"
  end
end