class Partage < ApplicationRecord
  validates :liste_id, presence: true
  validates :destinataire_id, uniqueness: {scope: :liste_id,
    message: "Liste déjà partagée avec cet utilisateur"}
  validate :exactly_one_user



  belongs_to :destinataire, class_name: "User", foreign_key: "destinataire_id"
  belongs_to :proprietaire, class_name: "User", foreign_key: "proprietaire_id"

  delegate :name, :pretty_name, to: :destinataire, prefix: true, allow_nil: true

  attr_accessor :destinataire_name
  attr_accessor :found

  private

  def exactly_one_user
    errors.add(:destinataire, "Plusieurs utilisateurs trouvés : #{found.join(" - ")}") if found.size > 1
    errors.add(:destinataire, "Aucun utilisateur trouvé") if found.size == 0
  end

end
