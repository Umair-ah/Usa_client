class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    mail(to: @order.email, subject: 'Your Order has been recieved!')
  end
end
