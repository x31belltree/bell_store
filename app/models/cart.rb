class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy
    has_many :products, through: :line_items
    
    def add_item(product_id)
        line_items.find_or_initialize_by(product_id: product_id)
    end
end
