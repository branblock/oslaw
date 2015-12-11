class Category < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  validates :name, length: { minimum: 5, maximum: 25 }, presence: true
  validates :description, length: { minimum: 5, maximum: 100 }, presence: true
  validates :user, presence: true

  def self.search(search)
    where("name || description LIKE ?", "%#{search}%")
  end
end
