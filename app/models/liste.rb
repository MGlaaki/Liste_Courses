class Liste < ApplicationRecord
  validates :nom_liste, :presence => true

  has_many :article, :dependent => :destroy
end
