class Color < ApplicationRecord
  belongs_to :product
  has_many :stocks
  has_many :line_items
end
