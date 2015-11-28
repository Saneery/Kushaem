class Food < ActiveRecord::Base
  before_save { |f| f.name = f.name.mb_chars.downcase.to_s }
  
  acts_as_taggable
  belongs_to :publick
  has_attached_file :image, styles: { medium: "300x300>"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :comments, :as => :commentable
  do_not_validate_attachment_file_type :image
  ratyrate_rateable 'original_score'
  
  def self.sort_by_rating
    Food.all.sort_by(&:rating).reverse
  end

  def rating
  	r = Rate.where rateable_id: self.id, rateable_type: 'Food'
    
    if r.size!=0
  	  r.sum(:stars)/r.size
    else
      0.0
    end
  end

  def image_url
    if self.image_file_name
      self.image.url
    else
      'no_image.png'
    end
  end
end
