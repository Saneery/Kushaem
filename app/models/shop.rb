class Shop < ActiveRecord::Base
  belongs_to :user
  has_many :foods
  has_attached_file :avatar
  has_many :comments, :as => :commentable
end
