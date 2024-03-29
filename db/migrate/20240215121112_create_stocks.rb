class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks, id: :uuid do |t|
      t.references :product, type: :uuid, foreign_key: true
      t.string :size
      t.integer :piece

      t.timestamps
    end
  end
end
