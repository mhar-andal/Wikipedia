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
end
