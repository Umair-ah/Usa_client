class Stock < ApplicationRecord
  belongs_to :product

  belongs_to :color
  has_many :line_items
  has_many :products, through: :line_items


  validates :size, presence: true
  validates :piece, presence: true
  validate :unique_sizes_per_color
  validate :valid_size_format

  def available?
    self.piece > 0
  end

  def unique_sizes_per_color
    if Stock.where(color_id: color_id, size: size).where.not(id: id).exists?
      errors.add(:size, "#{self.size} already exists")
    end
  end

  def valid_size_format
    unless size =~ /\A(XS|S|M|L|XL|XXL|XXXL)\z/
      errors.add(:size, "is not valid. It should be one of XS, S, M, L, XL, XXL, or XXXL")
    end
  end
end
