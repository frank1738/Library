class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :reservation_date, presence: true
end
