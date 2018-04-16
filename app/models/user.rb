class User < ApplicationRecord
  attr_accessor :password

  validates :name, :presence => true
  validates_length_of :password, :minimum => 6
  validates_uniqueness_of :name, :case_sensitive => false
  validates_confirmation_of :password
  before_save :encrypt_password

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password,salt)
  end

  def self.authenticate(name,password)
    user = User.where(name: name).first
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.salt)
      user
    else
      nil
    end
  end

end
