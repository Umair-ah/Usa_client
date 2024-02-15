class Product < ApplicationRecord
  belongs_to :category
  has_rich_text :description
  has_many_attached :images

  has_many :stocks

  has_many :line_items
end
