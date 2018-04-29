class Partage < ApplicationRecord
  validates :liste_id, presence: true

  belongs_to :user, foreign_key: "destinataire_id"

  attr_accessor :destinataire_name
end
