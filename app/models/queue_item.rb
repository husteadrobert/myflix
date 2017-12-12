class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video



  def rating
    review = Review.find_by(user_id: self.user_id, video_id: self.video_id)
    review.rating if review
  end

  def category_name
    category.name
  end

end