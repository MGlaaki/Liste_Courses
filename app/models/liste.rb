class Liste < ApplicationRecord
  validates :nom_liste, presence:{
    message: "Nom liste vide"}
  validates :nom_liste, length: {maximum: 30,
    too_long: "Le nom de la liste doit faire moins de %{count} caractères"}
  validates :nom_liste, format: {with: /\A[a-zA-Z\d\s]*\z/,
    message: "Seuls les caractères alphanumériques ainsi que \"-\" et \"_\" sont autorisés"}
  validates :nom_liste, uniqueness: {scope: [:nom_liste, :user_id],
    message: "Vous avez déjà une liste avec ce nom"}

  has_many :articles,dependent: :destroy
  has_many :partages, dependent: :destroy
  has_many :partages_users, through: :partages, class_name: "User", source: :destinataire


  belongs_to :user

  delegate :name, :pretty_name, to: :user, prefix: true, allow_nil: true

  #scope :owner_and_shared_with

  def self.owner_and_shared_with(id)
    Liste.references(:partages)
         .includes(partages: :destinataire)
         .includes(:user)
         .where("partages.destinataire_id ='?' OR listes.user_id='?'", id.to_i, id.to_i)
  end

  def beautiful_name(id)
    user_id == id ? nom_liste : "#{nom_liste} (#{user.name.capitalize})"
  end


end
