class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing, only: %i[show edit update destroy]

  # GET /borrowings or /borrowings.json
  def index
    @borrowings = Borrowing.all
  end

  # GET /borrowings/1 or /borrowings/1.json
  def show; end

  # GET /borrowings/new
  def new
    @borrowing = Borrowing.new
    @book = Book.find(params[:book_id])
  end

  def blog; end

  # GET /borrowings/1/edit
  def edit; end

  # POST /borrowings or /borrowings.json
  def create
    borrowing = Borrowing.new(borrowing_params)
    borrowing.user = current_user

    if Borrowing.where(book_id: borrowing.book_id, user_id: borrowing.user_id).exists?
      return redirect_to books_path, notice: 'Already Borrowed this book.'
    end

    if Borrowing.where(user_id: borrowing.user_id).count >= 3
      return redirect_to books_path, notice: ' Already Borrowed three books.'
    end

    return redirect_to books_path, notice: 'Borrowed the Book successifuly' if borrowing.save

    render('new', status: 422)
  end

  # PATCH/PUT /borrowings/1 or /borrowings/1.json
  def update
    respond_to do |format|
      if @borrowing.update(borrowing_params)
        format.html { redirect_to borrowings_path, notice: 'Updated your details successfully.' }
        format.json { render :show, status: :ok, location: @borrowing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @borrowing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /borrowings/1 or /borrowings/1.json
  def destroy
    @borrowing.destroy

    respond_to do |format|
      format.html { redirect_to borrowings_url, notice: 'Updated your details successfully' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def borrowing_params
    params.require(:borrowing).permit(:borrowing_date, :due_date, :user_id, :book_id)
  end
end
