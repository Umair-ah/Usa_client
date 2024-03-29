class AddStockReferencesToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_items, :stock, type: :uuid, null: false, foreign_key: true
  end
end
