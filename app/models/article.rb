class Article < ApplicationRecord
  validates :article, :presence => true

  belongs_to :liste

  default_scope {order(:created_at)}

end
