class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.string :title
      t.string :content_rating
      t.integer :recommend_rating
      t.float :average_rating
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :book, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
