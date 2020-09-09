class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:favorites]

  def index
    @q_product = Product.ransack(params[:q])
    @products = @q_product.result.page(params[:page])
  end

  def favorites
    @q_product = current_user.fav_products.ransack(params[:q])
    @products = @q_product.result.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @cart = @product.cart_items.build
  end
end