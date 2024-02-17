class Stock < ApplicationRecord
  belongs_to :product

  def available?
    self.piece > 0
  end
end
