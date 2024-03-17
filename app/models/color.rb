class Color < ApplicationRecord
  belongs_to :product
  has_many :stocks
  has_many :line_items

  validates :name, presence: true
end
