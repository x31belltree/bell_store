class Product < ApplicationRecord
    mount_uploader :image, ImagesUploader
    has_many :reviews
    has_many :favorites
    has_many :user, through: :favorites
 
    
    def favorite_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
