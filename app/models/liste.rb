class Liste < ApplicationRecord
  validates :nom_liste, :presence => true
  validates_length_of :nom_liste, :maximum => 30
  validates :nom_liste, uniqueness: {scope: [:nom_liste, :utilisateur]}

  has_many :article, :dependent => :destroy
end
