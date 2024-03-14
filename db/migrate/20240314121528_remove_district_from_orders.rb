class RemoveDistrictFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :district, :string
  end
end
