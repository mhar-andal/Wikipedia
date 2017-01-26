class Section < ApplicationRecord
  belongs_to :article
  has_many :revisions, as: :revisionable

  def current_revision
    Revision.find(self.current_revision_id)
  end

  def newest_revision
    self.revisions[0] ? self.revisions[0] : nil
  end

end
