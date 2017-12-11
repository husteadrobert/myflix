class Video < ActiveRecord::Base
  belongs_to :category

  has_many :reviews
  # validates :title, presence: true
  # validates :description, presence: true

  validates_presence_of :title, :description

  def self.search_by_title(terms)
    return [] if terms.blank?
    where("lower(title) LIKE ?", "%#{terms.downcase}%").order("created_at ASC")
  end

  def average_rating
    if !self.reviews.blank?
      (self.reviews.map{ |e| e[:rating] }.inject(0, :+) / reviews.length.to_f).round(1)
    else
      0
    end
  end
end