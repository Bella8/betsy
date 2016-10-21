class PaymentDetailsController < ApplicationController
    before_action :get_payment_details, only: [:show]
    skip_before_action :require_login

  def show; end

  def new
    @payment_details = PaymentDetail.new
  end

  def create
    @payment_details = PaymentDetail.new(payment_details_params)
    @payment_details.record_time_placed
    if @payment_details.save
      reset_session_values
      Order.find(params[:order_id]).mark_order_paid
      redirect_to @payment_details
    else
       render :new
    end
  end

  private
    def get_payment_details
      @payment_details = PaymentDetail.find(params[:id])
    end

    def payment_details_params
      params.require(:payment_details).permit(:buyer_name, :email, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip, :order_id)
    end

    def reset_session_values
      session[:order_id] = nil
      session[:product_id] = nil
    end
end
