class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.uuid :product_id, null: false, foreign_key: true
      t.uuid :cart_id, null: false, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
