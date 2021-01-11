module LikeSearchable
  extend ActiveSupport::Concern

  included do
    # scope são consultas comumente usadas que podem ser referenciadas como chamadas de métodos
    # nos objetos ou em modelo de associações. Ex: Category.like('nome_do_campo', 'nome_que_deseja_encontrar')
    scope :like, -> (key, value) do
      self.where(self.arel_table[key].matches("%#{value}%"))
    end
  end  
end