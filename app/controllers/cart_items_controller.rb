class CartItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_cart_item, only: [:show, :update, :destroy, :edit]
  before_action :set_user

  def create
    @cart_item = current_user.cart_items.build(cart_item_params)
    @current_item = CartItem.find_by(product_id: @cart_item.product_id,user_id: @cart_item.user_id)
    # カートに同じ商品がなければ新規追加、あれば既存のデータと合算
    if @current_item.nil?
      if @cart_item.save
        flash[:success] = 'カートに商品が追加されました！'
        redirect_to cart_items_path
      else
        @carts_items = @user.cart_items.all
        render 'index'
        flash[:danger] = 'カートに商品を追加できませんでした。'
      end
    else
      @current_item.quantity += params[:quantity].to_i
      @current_item.update(cart_item_params)
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path
    flash[:info] = 'カートの商品を取り消しました。'
  end

  def index
    @cart_items = @user.cart_items.all
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
      flash[:success] = 'カート内の商品を更新しました！'
    end
  end

  def destroy_all #カート内アイテム全部消去
    @user.cart_items.destroy_all
    redirect_to cart_items_path
    flash[:info] = 'カートを空にしました。'
  end

  private

  def set_user
    @user = current_user
  end

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :user_id, :quantity)
  end
end
