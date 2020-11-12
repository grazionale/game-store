class SystemRequirement < ApplicationRecord
  # :restrict_with_error 
  # Isso quer dizer que toda vez um SystemRequirement for excluído, ele será 
  # impedido caso haja algum Game associado
  has_many :games, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :operational_system, presence: true
  validates :storage, presence: true
  validates :processor, presence: true
  validates :memory, presence: true
  validates :video_board, presence: true
end
