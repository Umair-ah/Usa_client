class Color < ApplicationRecord
  belongs_to :product
  has_many :stocks
  has_many :line_items

  validates :name, presence: true
  validate :uniqur_color_per_product

  def uniqur_color_per_product
    if Color.where(product_id: product_id, name: name).where.not(id: id).exists?
      errors.add(:name, "#{self.name} Color already exists")
    end
  end
end
