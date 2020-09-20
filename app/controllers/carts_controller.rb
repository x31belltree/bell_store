class CartsController < ApplicationController
  before_action :set_cart, only: [:index, :destroy]
  
  def index
    @line_items = current_cart.line_items.all
  end

  def destroy
    @cart.destroy
    redirect_to root_path, notice: 'カートの中身をすべて削除しました'
  end

  private
    def set_cart
      @cart = current_cart
    end

    def cart_params
      params.fetch(:cart, {})
    end
end
