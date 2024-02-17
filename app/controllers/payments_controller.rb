class PaymentsController < ApplicationController

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