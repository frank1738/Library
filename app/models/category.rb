class Category < ApplicationRecord
    has_many :books, dependent: :destroy

    validates :name, presence:true
    validates :image_url, presence:true
end