class Stock < ApplicationRecord
  belongs_to :product

  belongs_to :color
  has_many :line_items
  has_many :products, through: :line_items

  validates :piece, presence: true

  def available?
    self.piece > 0
  end
end
