class ReviewsController < ApplicationController
  before_action :set_product
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :if_not_admin, only: [:edit, :update, :destroy]

  # GET /reviews
  def index
    @reviews = @product.reviews.order(updated_at: "DESC")
  end

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    @review = @product.reviews.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  def create
    @review = @product.reviews.new(review_params)

    if @review.save
      redirect_to @product, notice: 'Review was successfully created.' 
    else
      render :new
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      redirect_to @product, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
    redirect_to product_url, notice: 'Review was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def set_product
      @product = Product.find_by(id: params[:product_id])
      redirect_to(product_url, alert: "ERROR!!") if @product.blank?
    end
    
    def set_review
      @review = @product.reviews.find_by(id: params[:id])
    end
    
    def if_not_admin
      redirect_to root_path unless current_user.admin?
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:name, :comment, :rate, :user_id, :product_id)
    end
end
