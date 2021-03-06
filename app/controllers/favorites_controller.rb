class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.build(product_id: params[:product_id])
    favorite.save!
    redirect_to products_path, success: t('.flash.favorite')
  end
  
  def destroy
    current_user.favorites.find_by(product_id: params[:product_id]).destroy!
    redirect_to products_path, success: t('.flash.not_favorite')
  end
  
  private
  # Only allow a list of trusted parameters through.
  def favorite_params
    params.require(:favorite).permit(:product, :user)
  end
end
