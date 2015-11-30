class User < ActiveRecord::Base
  validates_presence_of :username, :email, :zipcode
  validates_uniqueness_of :username
  validates_length_of :zipcode, is: 5
  has_many :offers
  has_many :searches
  has_secure_password
  # def editor? NOTE: role auth
  #  self.role == 'editor'
  # end
  # def admin? NOTE: role auth
  #   self.role == 'admin'
  # end

  def to_s
    username
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
