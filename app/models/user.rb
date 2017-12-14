class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :reviews
  has_many :queue_items, -> { order("position") }

  # validates_presence_of :name, :email_address, :password
  # validates_uniqueness_of :email

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true


  def normalize_queue_item_positions
    self.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def queued_video?(video)
    #!!self.queue_items.find_by(video_id: video.id)
    queue_items.map(&:video).include?(video)
  end
end