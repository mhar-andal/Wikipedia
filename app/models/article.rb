class Article < ApplicationRecord
  has_many :sections
  has_many :bibliographies
  belongs_to :author, class_name: :User
  has_many :revisions, as: :revisionable
  has_many :notes
  has_many :revisioned_sections, through: :sections, source: :revisions

  # def self.alphabetical
  #   self.joins("JOIN revisions ON articles.current_revision_id = revisions.id AND revisions.publication_status = true").order('revisions.title')
  # end

  # def current_revision
  #   Revision.find(self.current_revision_id)
  # end

  # def newest_revision
  #   self.revisions[0] ? self.revisions[0] : nil
  # end

end
