class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update destroy]

  # GET /books or /books.json
  def index
    @books = if params[:query].present?
               query = "%#{params[:query]}%"
               @books = Book.where('title ILIKE ? OR author ILIKE ?', query, query)
             else
               Book.all
             end

    if turbo_frame_request?
      render partial: 'books', locals: { books: @books }
    else
      render 'index'
    end
  end

  # GET /books/1 or /books/1.json
  def show
    authorize! :read, @book
  end

  # GET /books/new
  def new
    @book = Book.new
    authorize! :create, @book
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    authorize! :update, @book
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_path, notice: 'Created the book  successfully .' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_path, notice: ' updated the Book successfully .' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    authorize! :destroy, @book
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_path, notice: 'destroyed. this Book successfully ' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_book
    @book = Book.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def book_params
    params.require(:book).permit(:title, :author, :image_url, :category_id)
  end
end
