class ChangeReviewContentRatingDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :content_rating, 'integer USING content_rating::integer'
  end
end
