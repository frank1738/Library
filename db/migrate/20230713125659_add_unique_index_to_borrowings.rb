class AddUniqueIndexToBorrowings < ActiveRecord::Migration[7.0]
  def change
    add_index :borrowings, :book_id, unique: true
  end
end
