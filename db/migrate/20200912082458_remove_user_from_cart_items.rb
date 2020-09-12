class RemoveUserFromCartItems < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :cart_items, :users
    remove_reference :cart_items, :user, index: true
  end
end
