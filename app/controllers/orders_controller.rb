class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @orders = @user.orders
  end
  
  def create
    if current_customer.cart_items.exists?
      @order = Order.new(order_params)
      @order.user_id = current_user.id

      # 住所のラジオボタン選択に応じて引数を調整
      @add = params[:order][:add].to_i
      case @add
        when 1
          @order.send_to_address = @customer.address
          @order.addressee = full_name(@customer)
        when 2
          @order.send_to_address = params[:order][:send_to_address]
          @order.addressee = params[:order][:addressee]
      end
      @order.save

      current_user.cart_items.each do |cart_item|
        order_item = @order.order_items.build
        order_item.order_id = @order.id
        order_item.product_id = cart_item.product_id
        order_item.quantity = cart_item.quantity
        order_item.order_price = cart_item.product.price
        order_item.save
        cart_item.destroy
      end
      render :thanks
    else
      redirect_to customer_top_path
　　　flash[:danger] = 'カートが空です。'
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.user_id != current_user.id
      redirect_back(fallback_location: root_path)
      flash[:alert] = "アクセスに失敗しました。"
    end
  end
  
  def new
    @order = Order.new
  end
  
  def confirm
    @order = Order.new
    @cart_items = current_user.cart_items
    @order.how_to_pay = params[:order][:how_to_pay]
    
    @add = params[:order][:add].to_i
    case @add
      when 1
        @order.send_to_address = @user.address
        @order.addressee = @user.name
      when 2
        @order.send_to_address = params[:order][:new_add][:address]
        @order.addressee = params[:order][:new_add][:addressee]
    end
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
