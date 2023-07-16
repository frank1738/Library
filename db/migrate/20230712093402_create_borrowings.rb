class CreateBorrowings < ActiveRecord::Migration[7.0]
  def change
    create_table :borrowings do |t|
      t.date :borrowing_date
      t.date :due_date
      t.references :user, null: false, foreign_key: true,type: :integer
      t.references :book, null: false, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
