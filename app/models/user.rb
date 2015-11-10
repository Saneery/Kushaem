class User < ActiveRecord::Base
  has_many :publicks
  has_attached_file :avatar
  has_secure_password
  ratyrate_rater

  def admin?
  	self.role == 'admin'
  end
  def editor?
  	self.role == 'editor'
  end

end
