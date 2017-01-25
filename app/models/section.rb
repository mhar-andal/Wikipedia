class Section < ApplicationRecord
  belongs_to :article
  has_many :revisions, as: :revisionable
end
