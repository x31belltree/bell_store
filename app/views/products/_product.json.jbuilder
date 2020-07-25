json.extract! product, :id, :name, :detail, :price, :category, :image, :stock, :created_at, :updated_at
json.url product_url(product, format: :json)
