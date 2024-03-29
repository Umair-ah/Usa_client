class AddReferenceToCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :gender, type: :uuid, null: false, foreign_key: true
  end
end
