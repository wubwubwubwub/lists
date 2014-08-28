class User < ActiveRecord::Base
  
  attr_accessor :password
  
  before_save :encrypt_password
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true # , uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, length: { in: 6..15 }, on: :create
  validates :password_confirmation, presence: true


  def self.authenticate(username, password)
    user = find_by username: username
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
     user 
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
