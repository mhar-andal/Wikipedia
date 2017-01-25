class Article < ApplicationRecord
  has_many :sections, :bibliographies
  belongs_to :user
  has_many :revisions, as: :revisionable
  has_many :notes
  has_many :revisioned_sections, through: :sections, source: :revisions

end
