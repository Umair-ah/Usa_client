class CreateColors < ActiveRecord::Migration[7.0]
  def change
    create_table :colors, id: :uuid do |t|
      t.string :name
      t.references :product, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
