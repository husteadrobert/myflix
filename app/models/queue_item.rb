class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_numericality_of :position, {only_integer: true}

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating) #bypasses validation
    else
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false) #bypasses validation
    end
  end

  def category_name
    category.name
  end

  private

  def review
    #@review ||= Review.find_by(user_id: self.user_id, video_id: self.video_id)
    @review ||= Review.find_by(user_id: user.id, video_id: video.id)
  end

end