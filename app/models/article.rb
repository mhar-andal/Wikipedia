class Article < ApplicationRecord
  has_many :sections
  has_many :bibliographies
  belongs_to :author, class_name: :User
  has_many :revisions, as: :revisionable
  has_many :notes
  has_many :revisioned_sections, through: :sections, source: :revisions

end
