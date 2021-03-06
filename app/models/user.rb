class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_one_attached :avatar
  has_one_attached :card
  attr_accessor :remember_token, :reset_token

  before_save { self.email = email.downcase }
  validates :mobile, presence: true, length: { maximum: 13, minimum: 10 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, on: [:create, :update_password]
  VALID_STUDENT_NUMBER_REGEX = /\As\d{7}\z/
  validates :student_number, format: { with: VALID_STUDENT_NUMBER_REGEX }, allow_nil: true

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : 
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end 
    
    # Returns a new random token
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Remembers a user in the databse for persistent session.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
