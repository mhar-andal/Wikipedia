class Article < ApplicationRecord
  has_many :sections
  has_many :bibliographies
  belongs_to :author, class_name: :User
  has_many :revisions, as: :revisionable
  has_many :notes
  # has_many :revisioned_sections, through: :sections, source: :revisions

  def self.all_published
    self.all.select { |article| article.find_newest_revision(true) != nil }
  end

  def newest_revision(search_for_published = true) # true = published; false = unpublished
    self.revisions.each do |revision|
      if revision.publication_status == search_for_published
        return revision
      end
    end
    return nil
  end

  def self.alphabetical
    self.joins("JOIN revisions ON articles.id = revisions.revisionable_id AND revisions.publication_status = true").order('revisions.title')
  end
end
