class Category < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  # Only admin can create categories, so just test for presence
  validates :name, presence: true
  validates :description, presence: true
  validates :user, presence: true
end
