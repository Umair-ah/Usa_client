class Product < ApplicationRecord
  belongs_to :category
  has_rich_text :description
  has_many_attached :images

  validates :name, :price, presence: true

  has_many :stocks

  has_many :line_items
end
