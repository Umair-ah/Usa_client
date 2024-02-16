class Cart < ApplicationRecord

  belongs_to :user, optional: true

  has_many :line_items
  has_many :products, through: :line_items

  def sub_total
    sum = 0
    self.line_items.each do |line_item|
      sum += line_item.total
    end
    return sum
  end
end
