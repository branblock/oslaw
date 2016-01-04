class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  acts_as_votable

  validates :body, length: { minimum: 5 }, presence: true

  default_scope { order('updated_at ASC') }

  def points
    get_upvotes.size
  end
end
