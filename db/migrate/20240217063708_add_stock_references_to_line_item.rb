class AddStockReferencesToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_items, :stock, null: false, foreign_key: true
  end
end
