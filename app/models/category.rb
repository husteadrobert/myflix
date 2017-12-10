class Category < ActiveRecord::Base
  #has_many :videos, -> {order("title")}
  has_many :videos

  def recent_videos
    #result = self.videos.order("created_at DESC").limit(6)
    result = self.videos.order("created_at DESC").first(6)
  end
end