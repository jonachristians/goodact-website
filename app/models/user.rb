class User < ActiveRecord::Base
  before_save {self.email.downcase!}

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

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
