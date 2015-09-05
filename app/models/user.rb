class User < ActiveRecord::Base
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
