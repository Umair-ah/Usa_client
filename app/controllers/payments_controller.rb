class PaymentsController < ApplicationController

  def order
    razor_payment_id = params[:payment_id]
    razor_order_id = params[:order_id]
    razor_signature = params[:signature]
    first_name = params[:first_name]
    last_name = params[:last_name]
    phone_number = params[:phoneNumber]
    email = params[:email]
    pin_code = params[:pinCode]
    address_1 = params[:address_1]
    address_2 = params[:address_2]
    area_details = IndianPostalCodes.details(pin_code)
    order = Order.new
    @current_cart.line_items.each do |line_item|
      order.line_items << line_item
    end
    order.first_name = first_name
    order.last_name = last_name
    order.phone_number = phone_number
    order.email = email
    order.pin = pin_code
    order.state = area_details[:state]
    order.city = area_details[:city]
    order.district = area_details[:district]
    order.address_line_1 = address_1
    order.address_line_2 = address_2
    order.razor_payment_id = razor_payment_id
    order.razor_order_id = razor_order_id
    order.razor_signature = razor_signature

    order.save!
    @current_cart.destroy
    order.line_items.each do |line_item|
      stock = line_item.stock
      stock.decrement!(:piece, line_item.quantity)
    end

    new_cart = Cart.create
    session[:cart_id] = new_cart.id
    @current_cart = new_cart
  end

  def checkout

  end

  def razorpay

  end

  def select_payment_option
    if params[:radio] == "razorpay"
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream:
          turbo_stream.update(
            "order_btn",
            partial:"payments/order_btn"
          )
        }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream:
          turbo_stream.update(
            "order_btn",
            partial:"payments/cod_btn"
          )
        }
      end

    end

  end

end