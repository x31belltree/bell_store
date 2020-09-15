class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:update, :destroy]

  def create
    cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = cart.add_item(product.id)

    if @line_item.save
      redirect_to carts_path, notice: 'カートに商品を追加しました'
    else
      render :new
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to carts_path, notice: 'カートの商品を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @line_item.destroy
    redirect_to carts_path, notice: 'カートの商品を削除しました'
  end

  private
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id, :quantity)
    end
end
