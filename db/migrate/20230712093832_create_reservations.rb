class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :reservation_date
      t.references :user, null: false, foreign_key: true, type: :integer
      t.references :book, null: false, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
