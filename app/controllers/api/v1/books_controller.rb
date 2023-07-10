class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    @books = Book.all
    #eager load ==> .includes(:reviews)
    json_response "Index books successfully", true, { books: @books }, :ok
  end

  def show
    json_response "Show book successfully", true, { book: @book }, :ok
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    # params[:id] nhận từ url
    json_response "Cannot get book", false, {}, :not_found unless @book
  end
end