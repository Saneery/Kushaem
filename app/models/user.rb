class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { minimum: 3, maximum: 20}
  has_many :publicks
  has_attached_file :avatar
  has_secure_password
  ratyrate_rater
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  def admin?
  	self.role == 'admin'
  end
  def editor?
  	self.role == 'editor'
  end

  def image
    if self.avatar_file_name
      self.avatar.url
    else
      'no_image.png'
    end
  end

end
