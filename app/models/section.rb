class Section < ApplicationRecord
  belongs_to :article
  has_many :revisions, as: :revisionable

  def newest_revision(search_for_published = true) # true = published; false = unpublished
    self.revisions.each do |revision|
      if revision.publication_status == search_for_published
        return revision
      end
    end
    return nil
  end

  def latest_update
    self.revisions.all.last
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
  end
end
