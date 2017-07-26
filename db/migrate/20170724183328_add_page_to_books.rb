class AddPageToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :user_books, :page, :string, default: "1"
  end
end
