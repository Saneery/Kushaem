class Food < ActiveRecord::Base
  before_save { |f| f.name.downcase! }
  
  acts_as_taggable
  belongs_to :publick
  has_attached_file :image, styles: { medium: "300x300>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :comments, :as => :commentable
  do_not_validate_attachment_file_type :image
  ratyrate_rateable 'original_score'
  def rating
  	r = Rate.where rateable_id: self.id, rateable_type: 'Food'
  	r.sum(:stars)/r.size
  end
end
