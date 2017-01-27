class Article < ApplicationRecord
  has_many :sections
  has_many :bibliographies
  has_many :revisions, as: :revisionable
  has_many :notes
  belongs_to :author, class_name: :User
  belongs_to :category
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

  def self.newest_published
    self.all.order(created_at: :desc).find {|article| article.newest_revision != nil}
  end

  def latest_update
    self.revisions.all.last
  end

  def self.alphabetical
    self.joins("JOIN revisions ON articles.id = revisions.revisionable_id AND revisions.publication_status = true").order('revisions.title')
  end

  def up_for_publication?
    published_id = self.newest_revision ? self.newest_revision.id : 0
    unpublished_id = self.newest_revision(false) ? self.newest_revision(false).id : 0
    p "************************************"
    p self
    p "published_id: #{published_id}"
    p "unpubulished_id: #{unpublished_id}"
    p "************************************"
    if published_id < unpublished_id
      return true
    end
    self.sections.each do |section|
      if section.up_for_publication?
        return true
      end
    end
    return false
  end
end
