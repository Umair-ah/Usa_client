class Product < ApplicationRecord
  include AppendToHasManyAttached['images']
  belongs_to :category
  has_rich_text :description
  has_many_attached :images

  validates :images, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  has_many :colors

  validates :name, presence: true
  validates :price, presence: true


  has_many :stocks, through: :colors

  has_many :line_items
end
