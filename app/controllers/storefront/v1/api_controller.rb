module Storefront::V1
  class ApiController < ApplicationController
    include Authenticatable # concerm criado para forçar que o usuário esteja autenticado
  end
end