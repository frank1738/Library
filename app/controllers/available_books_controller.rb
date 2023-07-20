class AvailableBooksController < ApplicationController
    def index
        @books = Book.left_outer_joins(:borrowings, :reservations)
                               .where(borrowings: { id: nil }, reservations: { id: nil })
      end
end
