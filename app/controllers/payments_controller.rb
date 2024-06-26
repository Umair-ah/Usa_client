class PaymentsController < ApplicationController

  def get_pin
    pin = params[:pin]
    details = IndianPostalCodes.details(pin)
    render json: details
  end


  def index
    @orders = current_user.orders
  end

  def success
    @order = Order.find_by(stripe_session_id: params[:session_id])
    @session_details = Stripe::Checkout::Session.retrieve(params[:session_id])
    
    
    if @order
      puts "Order already exists for session ID: #{params[:session_id]}"
    else
      if @session_details.payment_status == "paid"
        @order = Order.new
        @order.stripe_session_id = params[:session_id]
        @order.amount_total = @session_details.amount_total / 100
        @order.email = @session_details.customer_details.email
        @order.name = @session_details.customer_details.name
        @order.phone_number = @session_details.customer_details.phone
        @order.city = @session_details.customer_details.address.city
        @order.state = @session_details.customer_details.address.state
        @order.pin = @session_details.customer_details.address.postal_code
        @order.address_line_1 =  @session_details.customer_details.address.line1
        if @session_details.customer_details.address.line2
          @order.address_line_2 =  @session_details.customer_details.address.line2
        end
        @current_cart.line_items.each do |line_item|
          @order.line_items << line_item
        end
        
        if current_user
          @order.user = current_user
        end
        
        @order.save!
        OrderMailer.order_email(@order).deliver_now
        @current_cart.destroy
        @order.line_items.each do |line_item|
          stock = line_item.stock
          stock.decrement!(:piece, line_item.quantity)
        end
        
        new_cart = Cart.create
        cookies.signed[:cart_id] = new_cart.id
        @current_cart = new_cart
      end
    end
  end

  def checkout
    @current_cart.line_items.each do |line_item|
      if !line_item.stock.available?
        line_item.destroy
      end
    end

    line_items = @current_cart.line_items.map do |item|
      {
        quantity: item.quantity,
        price_data: {
          product_data: {
            name: item.product.name,
            metadata: { product_id: item.product.id, size: item.stock.size, product_stock_id: item.stock.id },
          },
          currency: "usd",
          unit_amount: item.product.price.to_i * 100

        }
      }
    end

    Stripe.api_key = 'sk_test_51OxUeBB69a215LtGGMK9SwawvcieahIrqcXBCWuciBgcXCZFxCnbrFH2LYWSMVDfnRbJxZopnPmi6RnVUALXzRYL00rX43lf2Z'
    session = Stripe::Checkout::Session.create({
                mode: 'payment',
                line_items: line_items,
                success_url: CGI.unescape(success_url(session_id: '{CHECKOUT_SESSION_ID}')),
                cancel_url: cart_url(@current_cart),
                shipping_address_collection: {
                  allowed_countries: ['US']
                },
                phone_number_collection: {
                  enabled: true
                },
                ui_mode: 'hosted' # or 'hosted'
              })
    redirect_to session.url, allow_other_host: true

  end

end