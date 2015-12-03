class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  def self.search(search)
    where("title || body LIKE ?", "%#{search}%")
  end
end
