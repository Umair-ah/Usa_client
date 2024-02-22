class Category < ApplicationRecord
  has_one_attached :thumbnail
  
  has_many :products, dependent: :nullify

  validates :name, presence: true
end
