class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :documents, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  acts_as_taggable_on :tags
  acts_as_votable

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  scope :alphabetical, -> { order(title: :asc) }
  scope :most_liked, -> { order("cached_votes_up DESC").limit(5) }
  scope :updated, -> { order(updated_at: :desc).limit(5) }
  scope :most_recent, -> { order(created_at: :desc).limit(5) }

  def points
    get_upvotes.size
  end
end
