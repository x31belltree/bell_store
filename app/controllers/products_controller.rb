class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :favorites]
  before_action :if_not_admin, only: [:new, :edit, :update, :destroy]
  before_action :set_categories, only: [:edit, :new, :index]

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

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Product was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end
  
  def dynamic_select_category
    @category = Category.find(params[:category_id])
  end

  private
  
  def set_categories
    @parent_categories = Category.roots
    @default_child_categories = @parent_categories.first.children
    @default_grandchild_categories = @default_child_categories.first.children
  end
  
  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :detail, :price, :category, :image, :stock)
  end
end
