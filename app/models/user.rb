class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :reviews

  validates :name, presence: true
  validates :email_address, presence: true, uniqueness: true
  validates :password, presence: true

end