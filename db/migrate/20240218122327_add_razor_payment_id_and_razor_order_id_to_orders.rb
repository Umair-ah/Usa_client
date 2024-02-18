class AddRazorPaymentIdAndRazorOrderIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :razor_payment_id, :string
    add_column :orders, :razor_order_id, :string
    add_column :orders, :razor_signature, :string
    add_column :orders, :district, :string


  end
end
