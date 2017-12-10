class Video < ActiveRecord::Base
  belongs_to :category

  # validates :title, presence: true
  # validates :description, presence: true

  validates_presence_of :title, :description

  def self.search_by_title(terms)
    return [] if terms.blank?
    where("lower(title) LIKE ?", "%#{terms.downcase}%").order("created_at ASC")
  end
end