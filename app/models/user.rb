class User < ApplicationRecord
  has_secure_password
  has_many :articles, foreign_key: :author_id

  validates :username, {uniqueness: true, presence: true, case_sensitive: false}
  validates :password, length: { minimum: 8 }

  validate :password_must_contain_number

  def password_must_contain_number
    unless !!(password =~ /\d/)
      errors.add(:password, "must contain at least one number")
    end
  end

  def published_articles
    self.articles.select{|article| ( (article.newest_revision != nil) && (article.submission_status == "unsubmitted") ) }
  end

  def unpublished_articles
    self.articles.select{|article| ((article.up_for_publication?) && (article.submission_status == "unsubmitted") )}
  end
end
