class User < ActiveRecord::Base
  validates_presence_of :username, :email, :zipcode
  has_many :offers
  has_many :searches
  has_secure_password
  def editor?
   self.role == 'editor'
  end
  def admin?
    self.role == 'admin'
  end
end
