class AddReferenceToStock < ActiveRecord::Migration[7.0]
  def change
    add_reference :stocks, :color, type: :uuid, null: false, foreign_key: true
  end
end
