class User < ActiveRecord::Base
  include Tokenable
  has_secure_password validations: false

  has_many :reviews, -> { order("created_at DESC") }
  has_many :queue_items, -> { order("position") }

  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

  # validates_presence_of :name, :email_address, :password
  # validates_uniqueness_of :email

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true

  #before_create :generate_token


  def normalize_queue_item_positions
    self.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index+1)
    end
  end

  def queued_video?(video)
    #!!self.queue_items.find_by(video_id: video.id)
    queue_items.map(&:video).include?(video)
  end

  def follows?(another_user)
    following_relationships.map(&:leader).include?(another_user)
  end

  def can_follow?(another_user)
    !(self.follows?(another_user) || self == another_user)
    #self != another_user && !self.following_relationships.map(&:leader).include?(another_user)
  end

  # def generate_token
  #   self.token = SecureRandom.urlsafe_base64
  # end

  def follow(another_user)
    # Relationship.create(follower_id: self.id, leader_id: another_user.id) if self.can_follow?(another_user)
    # self.reload
    following_relationships.create(leader: another_user) if self.can_follow?(another_user)
  end

end