class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.timestamps
      t.string :body
      t.integer :rating
      t.integer :video_id
      t.integer :user_id
    end
  end
end
