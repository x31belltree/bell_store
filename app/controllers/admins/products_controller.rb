class Admins::ProductsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_categories, only: %w[edit new]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def edit
  end

  def index
    @q_product = Product.ransack(params[:q])
    @products = @q_product.result.page(params[:page])
  end

  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    
    if @product.save
      redirect_to admins_products_path, notice: 'Product was successfully created.'
    else
      render :new
    end
  end
  
  def update
    if @product.update(product_params)
      redirect_to admins_products_path, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @product.destroy
    redirect_to admins_products_url, notice: 'Product was successfully destroyed.'
  end
  
  def dynamic_select_category
    @category = Category.find(params[:category_id])
  end
  
  private
  def set_categories
    @parent_categories = Category.roots
    @default_child_categories = @parent_categories.first.children
  end

  def set_product
    @product = Product.find(params[:id])
  end
  
  def product_params
    params.require(:product).permit(:name, :detail, :price,  :image, :stock , category_ids: [])
  end
end

