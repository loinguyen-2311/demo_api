class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :image
  # ,
  #            :content_rating_of_book, :recommend_rating_of_book, :average_rating_of_book, :total_reviews
  has_many :reviews

  # object do serializer khoi tao san
  # def average_rating_of_book
  #   # object.reviews.count == 0 ? 0 : object.reviews.average(:average_rating).round(1)
  #   object.reviews.count == 0 ? 0 : object.reviews.average(:average_rating).round(1)
  # end
  #
  # def content_rating_of_book
  #   object.reviews.count == 0 ? 0 : object.reviews.average(:content_rating).round(1).to_f
  # end
  #
  # def recommend_rating_of_book
  #   object.reviews.count == 0 ? 0 : object.reviews.average(:recommend_rating).round(1).to_f
  # end
  #
  # def total_reviews
  #   object.reviews.count
  # end
end
