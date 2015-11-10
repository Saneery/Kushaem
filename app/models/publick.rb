class Publick < ActiveRecord::Base
  before_save { |publick| publick.name.downcase! }
  
  belongs_to :user
  has_many :foods
  has_attached_file :avatar
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :comments, :as => :commentable
  has_many :complaints
  ratyrate_rateable 'original_score'
  #надо написать коллбэк возращающий рейтинг
  def rating
  	r = Rate.where rateable_id: self.id, rateable_type: 'Shop'
  	r.sum(:stars)/r.size
  end
end
