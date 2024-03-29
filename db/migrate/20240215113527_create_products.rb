class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.uuid :category_id
      t.string :name
      t.decimal :price

      t.timestamps
    end
  end
end
