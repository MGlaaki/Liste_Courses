class Liste < ApplicationRecord
  has_many :article, :dependent => :destroy
end
