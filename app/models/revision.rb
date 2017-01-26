class Revision < ApplicationRecord
  belongs_to :revisionable, polymorphic: true

  validates :title, presence: true
  validates :paragraph, presence: true
  
end
