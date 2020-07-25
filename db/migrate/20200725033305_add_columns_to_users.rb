class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :admin, :boolean, default: false
    add_column :users, :uid, :string
    add_column :users, :provider, :string
  end
end
