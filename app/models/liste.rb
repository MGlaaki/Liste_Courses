class Liste < ApplicationRecord
  validates :nom_liste, :presence => true
  validates_length_of :nom_liste, :maximum => 30
  validates :nom_liste, uniqueness: {scope: [:nom_liste, :user_id]}

  has_many :article, :dependent => :destroy

  has_many :partages
  belongs_to :user

  def self.owner_and_shared_with(id)
    Liste.references(:partages)
                   .includes(partages: :user)
                   .includes(:user)
                   .where("partages.destinataire_id = ? OR listes.user_id=?", id, id) 
  end

end
