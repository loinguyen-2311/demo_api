class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :content_rating, :recommend_rating, :average_rating
  # two line below to add user and book relation to review
  belongs_to :user
  belongs_to :book
end
