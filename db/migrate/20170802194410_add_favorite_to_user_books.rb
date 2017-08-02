class AddFavoriteToUserBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :user_books, :favorite, :boolean, default: false
  end
end
