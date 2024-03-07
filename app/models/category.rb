class Category < ApplicationRecord
  has_one_attached :thumbnail

  belongs_to :gender
  
  has_many :products, dependent: :nullify

  validates :name, presence: true
end
