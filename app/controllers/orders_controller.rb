class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @orders = @user.orders
  end

  def new
    @order = Order.new
  end

  def show
  end

  def confirm
  end
  
  def thanks
  end
  
  private
  def set_user
    @user = current_user
  end

  def order_params
    params.require(:order).permit(
      :created_at, :send_to_address, :addressee, :order_status, :how_to_pay, :post_code, :deliver_fee,
      order_items_attributes: [:order_id, :product_id, :quantity, :order_price, :make_status]
      )
  end
end
