class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: %i[show edit update destroy]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show; end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @book = Book.find(params[:book_id])
    @available_date = Borrowing.find_by(book_id: params[:book_id]).due_date
  end

  # GET /reservations/1/edit
  def edit; end

  # POST /reservations or /reservations.json
  def create
    reservation = Reservation.new(reservation_params)
    reservation.user = current_user
    if Reservation.where(book_id: reservation.book_id, user_id: reservation.user_id).exists?
      return redirect_to books_path, notice: 'already reserved this book.'
    end
    if Reservation.where(user_id: reservation.user_id).count >= 3
      return redirect_to books_path, notice: 'already three books'
    end

    if reservation.save
      return redirect_to books_path,
                         notice: 'created this Reservation successfully .'
    end

    render('new', status: 422)
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservations_path, notice: 'updated this  Reservation successfully .' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'destroyed the Reservation  successfully .' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:reservation_date, :user_id, :book_id)
  end
end
