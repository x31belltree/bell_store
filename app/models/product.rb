class Product < ApplicationRecord
    mount_uploader :image, ImagesUploader
    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories
    has_many :reviews
    has_many :favorites
    has_many :line_items
    has_many :user, through: :favorites
    has_many :order_items
    
    def favorite_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
