class Api::V1::ReviewsController < ApplicationController

  # before_action :load_book, only: :index
  before_action :load_review, only: [:show, :update, :destroy]
  before_action :authenticate_with_token!, only: [:create, :update, :destroy]

  def index
    # Ví dụ truy vấn ban đầu (N+1 Query)
    @reviews = Review.all

    # Vòng lặp để truy vấn thông tin user và book của từng review
    @reviews.each do |review|
      puts review.user.email
      puts review.book.title
    end

    # @reviews = @book.reviews
    # json_response "Index reviews successfully", true, { reviews: parse_json(@reviews) }, :ok
  end

  def show
    json_response "Show reviews successfully", true, { reviews: parse_json(@review) }, :ok
  end

  def create
    review = Review.new review_params
    review.user_id = current_user.id
    review.book_id = params[:book_id]
    return json_response "Created review successfully", true, { review: parse_json(review) }, :ok if review.save
    json_response "Created review fail", fale, {}, :unproccessable_entity
  end

  def update
    if correct_user @review.user
      return json_response "Updated review successfully", true, { review: parse_json(@review) }, :ok if @review.update review_params
      return json_response "Updated review fail", false, {}, :unproccessable_entity
    end
    json_response "You dont have permission to do this", false, {}, :unauthorized
  end

  def destroy
    if correct_user @review.user
      return json_response "Deleted review successfully", true, {}, :ok if @review.destroy
      return json_response "Deleted review fail", false, {}, :unproccessable_entity
    end
    json_response "You dont have permission to do this", false, {}, :unauthorized
  end

  private

  def load_book
    @book = Book.find params[:book_id]
    json_response "Cannot find a book", false, {}, :not_found unless @book
  end

  def load_review
    @review = Review.find params[:id]
    json_response "Cannot find a review", false, {}, :not_found unless @review
  end

  def review_params
    params.require(:review).permit :title, :content_rating, :recommend_rating, :image_review
  end
end