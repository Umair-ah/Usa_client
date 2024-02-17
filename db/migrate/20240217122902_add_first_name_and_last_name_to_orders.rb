class AddFirstNameAndLastNameToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
    add_column :orders, :phone_number, :string
    add_column :orders, :email, :string
    add_column :orders, :pin, :string
    add_column :orders, :state, :string
    add_column :orders, :city, :string
    add_column :orders, :address_line_1, :string
    add_column :orders, :address_line_2, :string

  end
end
