class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  acts_as_votable

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  # refactor to avoid SQL queries
  def self.search(search)
    where("title || body LIKE ?", "%#{search}%")
  end

  def self.alphabetical
    self.order(title: :asc)
  end

  def self.most_liked
    self.order("cached_votes_score DESC").limit(5)
  end

  def self.updated
    self.order(updated_at: :desc).limit(5)
  end

  def self.most_recent
    self.order(created_at: :desc).limit(5)
  end
end
