class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 25 }, presence: true
  validates :user, presence: true

  def self.search(search)
    where("title || body LIKE ?", "%#{search}%")
  end
end
