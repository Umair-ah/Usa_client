class Stock < ApplicationRecord
  belongs_to :product
  has_many :line_items
  has_many :products, through: :line_items

  validates :size, uniqueness: true
  validates :piece, presence: true

  def available?
    self.piece > 0
  end
end
