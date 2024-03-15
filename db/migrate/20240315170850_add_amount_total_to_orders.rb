class AddAmountTotalToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :amount_total, :integer
  end
end
