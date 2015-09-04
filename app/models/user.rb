class User < ActiveRecord::Base
  has_many :offers
  has_many :searches
  has_secure_password
end
