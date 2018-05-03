class Partage < ApplicationRecord
  validates :liste_id, presence: true
  validates :destinataire_id, uniqueness: {scope: :liste_id,
    message: "Liste déjà partagée avec cet utilisateur"}


  belongs_to :destinataire, class_name: "User", foreign_key: "destinataire_id"
  belongs_to :proprietaire, class_name: "User", foreign_key: "proprietaire_id"

  delegate :name, :pretty_name, to: :destinataire, prefix: true, allow_nil: true

  attr_accessor :destinataire_name
end
