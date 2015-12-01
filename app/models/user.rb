class User < ActiveRecord::Base
  before_save {self.email.downcase!}
  attr_accessor :remember_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :username,
            presence: true,
            uniqueness: true,
            length: { maximum: 30 }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX}
  validates :zipcode,
            presence: true,
            numericality: true,
            length: { is: 5 }
  validates :password,
            presence: true
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

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forget a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end
end
