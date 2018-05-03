class User < ApplicationRecord
  attr_accessor :password

  validates :name, presence: {
    message: "Merci d'entrer un nom d'utilisateur."}
  validates :name, format: {with: /\A[a-zA-Z\d\s]*\z/,
    message: "Seuls les caractères alphanumériques ainsi que \"-\" et \"_\" sont autorisés."}
  validates :name, length: {maximum: 60,
    too_long: "Le nom d'utilisateur doit faire moins de %{count} caractères."}
  validates :name, uniqueness: {case_sensitive: false,
    message: "Cet utilisateur existe déjà"}

  validates :password, length: {minimum: 6,
    too_short: "Le mot de passe doit faire au moins %{count} caractères."}
  validates :password, length: {maximum: 60,
    too_long: "Le mot de passe doit faire moins de %{count} caractères"}

  validates :password, confirmation: true
  before_save :encrypt_password
  has_many :partage
  has_many :listes

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

  def pretty_name
    name.capitalize
  end

end
