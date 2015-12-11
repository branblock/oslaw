class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :body, length: { minimum: 5 }, presence: true

  default_scope { order('updated_at ASC') }
end
