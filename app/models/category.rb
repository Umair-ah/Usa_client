class Category < ApplicationRecord
  has_one_attached :thumbnail
  
  has_many :products

  validates :name, presence: true
end
