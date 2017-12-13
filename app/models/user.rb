class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :reviews
  has_many :queue_items, -> { order("position") }

  # validates_presence_of :name, :email_address, :password
  # validates_uniqueness_of :email

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true

end