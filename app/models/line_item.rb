class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  belongs_to :stock
  belongs_to :color
  belongs_to :order, optional: true

  def total
    self.product.price * self.quantity
  end
end
