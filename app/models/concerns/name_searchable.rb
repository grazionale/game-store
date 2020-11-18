module NameSearchable
  extend ActiveSupport::Concern

  included do
    # scope são consultas comumente usadas que podem ser referenciadas como chamadas de métodos
    # nos objetos ou em modelo de associações. Ex: Category.search_by_name('nome_que_deseja_encontrar')
    scope :search_by_name, -> (value) do
      self.where("name ILIKE ?", "%#{value}%")
    end
  end  
end