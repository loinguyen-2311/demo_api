class RemoveReviewsCountFromBooks < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :reviews_count
  end
end
