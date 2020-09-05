class CategoriesController < ApplicationController
  before_action :set_category, only: :show
  def index
    @parents = Category.roots
  end
  
  def show
    @products = @category.set_products
  end
  
  private
  def set_category
    @category = Category.find(params[:id])
  end
end
