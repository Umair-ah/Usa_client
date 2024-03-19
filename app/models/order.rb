class Order < ApplicationRecord
  belongs_to :user, optional: true

  enum status: {
    "pending": 0,
    "out for delivery": 1,
    "completed": 2,
    "cancelled": 3
  }

  has_many :line_items, dependent: :destroy


  def order_total
    tot = 0
    self.line_items.each do |line_item|
      tot += line_item.total
    end
    return tot
  end
end
