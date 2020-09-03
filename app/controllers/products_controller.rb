class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:favorites]
  before_action :set_categories, only: [:index]

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
  
  private
  def set_categories
   @parent_categories = Category.roots
   @default_child_categories = @parent_categories.first.children
  end
end