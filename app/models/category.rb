class Category < ActiveRecord::Base
  has_many :posts
  belongs_to :user

  validates :name, length: { minimum: 5, maximum: 25 }, presence: true
  validates :description, length: { minimum: 5, maximum: 100 }, presence: true
  validates :user, presence: true
end
