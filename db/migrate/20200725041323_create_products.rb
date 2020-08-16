class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :detail
      t.integer :price
      t.string :image
      t.integer :stock

      t.timestamps
    end
  end
end
