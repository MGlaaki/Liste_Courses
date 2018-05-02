class Liste < ApplicationRecord
  validates :nom_liste, :presence => true
  validates_length_of :nom_liste, :maximum => 30
  validates :nom_liste, uniqueness: {scope: [:nom_liste, :user_id]}

  has_many :article, dependent: :destroy
  has_many :partages
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
