class AddIndexToOrders < ActiveRecord::Migration[7.0]
  def change
    add_index :orders, :stripe_session_id, unique: true
    remove_column :orders, :first_name
    remove_column :orders, :last_name
    
    add_column :orders, :name, :string

  end
end
