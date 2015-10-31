class Food < ActiveRecord::Base
  
  acts_as_taggable
  belongs_to :shop
  has_attached_file :image, styles: { medium: "300x300>"}
  has_many :comments, :as => :commentable
  do_not_validate_attachment_file_type :image
end
