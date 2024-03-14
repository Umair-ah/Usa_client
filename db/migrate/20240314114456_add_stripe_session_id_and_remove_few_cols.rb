class AddStripeSessionIdAndRemoveFewCols < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :stripe_session_id, :string
    remove_column :orders, :razor_payment_id
    remove_column :orders, :razor_order_id
    remove_column :orders, :razor_signature
  end
end
