class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :image_url
      t.references :category, null: false, foreign_key: true, type: :integer

      t.timestamps
    end
  end
end
