class Revision < ApplicationRecord
  belongs_to :revisionable, polymorphic: true
end
