class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :borrowing_date, presence:true
  validates :due_date, presence:true
end
