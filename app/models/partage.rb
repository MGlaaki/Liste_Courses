class Partage < ApplicationRecord
  validates :liste_id, presence: true

  belongs_to :destinataire, class_name: "User", foreign_key: "destinataire_id"

  delegate :name, :pretty_name, to: :destinataire, prefix: true, allow_nil: true

  attr_accessor :destinataire_name
end
