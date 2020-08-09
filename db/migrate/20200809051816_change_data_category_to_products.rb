class ChangeDataCategoryToProducts < ActiveRecord::Migration[5.2]
  def change
    change_column :products, :category, :reference
  end
end
