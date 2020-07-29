class Product < ApplicationRecord
    mount_uploader :image, ImagesUploader
    has_many :reviews
end
