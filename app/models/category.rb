class Category < ApplicationRecord
    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories
    has_ancestry
    
    def set_products
        if self.root?
            start_id = self.children.first.id
            end_id = self.children.last.id
            products = Product.where(category_id: start_id..end_id)
            return products
        else
            return self.products
        end
    end
end
