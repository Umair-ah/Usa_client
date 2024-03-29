class ChangeCartIdInLineItems < ActiveRecord::Migration[7.0]
  def change
    change_column :line_items, :cart_id, :uuid, null: true
  end
end
