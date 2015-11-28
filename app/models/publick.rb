class Publick < ActiveRecord::Base
  before_save { |publick| publick.name = publick.name.mb_chars.downcase.to_s }

  validates :name, :description, :address, :city, presence: true
  belongs_to :user
  has_many :foods
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :comments, :as => :commentable
  has_many :complaints
  ratyrate_rateable 'original_score'

  def self.sort_by_rating
    Publick.all.sort_by(&:rating).reverse
  end

  def rating
  	r = Rate.where rateable_id: self.id, rateable_type: 'Publick'
    
    if r.size!=0
      r.sum(:stars)/r.size
    else
      0.0
    end
  end

end
