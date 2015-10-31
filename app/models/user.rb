class User < ActiveRecord::Base
  has_many :shops
  has_attached_file :avatar
  has_secure_password

  def admin?
  	self.role == 'admin'
  end
  def editor?
  	self.role == 'editor'
  end

end
