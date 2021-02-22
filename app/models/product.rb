class Product < ApplicationRecord
  include LikeSearchable
  include Paginatable
  
  belongs_to :productable, polymorphic: true
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :image, presence: true
  validates :status, presence: true
  validates :featured, presence: true, if: -> { featured.nil? }

  enum status: { available: 1, unavailable: 2 }
  # O campo image não existe no banco mas é um recurso que podemos mapear no model e informar que 
  # ele terá um campo que vai referenciar um arquivo do Active Storage.
  # has_one_attached é um recurso do ActiveStorage que permite mapear um campo no model para arquivo
  has_one_attached :image
end
