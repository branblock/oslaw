class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  scope :alphabetical, -> { order(title: :asc) }
  scope :most_liked, -> (most_liked) { order(rank: :desc) }
  scope :most_recent, -> (most_recent) { order(created_at: :desc) }

  # refactor to avoid SQL queries
  def self.search(search)
    where("title || body LIKE ?", "%#{search}%")
  end

  def like
    likes.where(value: 1).count
  end

  def total_likes
    likes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = total_likes + age_in_days
    update_attribute(:rank, new_rank)
  end
end
