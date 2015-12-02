class Post < ActiveRecord::Base

  def self.search(search)
    where("title || body LIKE ?", "%#{search}%")
  end
end
