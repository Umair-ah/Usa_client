class Category < ApplicationRecord
  has_one_attached :thumbnail
  validates :thumbnail, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  belongs_to :gender
  
  has_many :products, dependent: :nullify

  validates :name, presence: true
end
