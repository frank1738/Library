class Book < ApplicationRecord
  belongs_to :category
  has_many :borrowings, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates :title, presence: true
  validates :author, presence: true
  validates :image_url, presence: true
end
