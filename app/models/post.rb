class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  acts_as_taggable
  acts_as_taggable_on :tags
  acts_as_votable

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  def self.alphabetical
    order(title: :asc)
  end

  def self.most_liked
    order("cached_votes_up DESC").limit(5)
  end

  def self.most_unliked
    order("cached_votes_down DESC").limit(5)
  end

  def self.updated
    order(updated_at: :desc).limit(5)
  end

  def self.most_recent
    order(created_at: :desc).limit(5)
  end
end
