class User < ActiveRecord::Base
  validates_presence_of :username, :email, :zipcode
  validates_uniqueness_of :username
  has_many :offers
  has_many :searches
  has_secure_password
  # def editor? NOTE: role auth
  #  self.role == 'editor'
  # end
  # def admin? NOTE: role auth
  #   self.role == 'admin'
  # end
end
