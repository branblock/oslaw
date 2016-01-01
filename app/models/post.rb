class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  acts_as_taggable_on :tags
  acts_as_votable

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  scope :alphabetical, -> { order(title: :asc) }
  scope :most_liked, -> { order("cached_votes_up DESC").limit(5) }
  scope :updated, -> { order(updated_at: :desc).limit(5) }
  scope :most_recent, -> { order(created_at: :desc).limit(5) }

  # For document uploads via paperclip
  has_attached_file :document
  validates_attachment :document, content_type: { content_type: ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/pdf"] }, size: { in: 0..8.megabytes }

  # , {
  #   :url => "word_document/:basename.:extension",
  #   :path => ":rails_root/public/word_document/:basename.:extension"
  # }

  # mime_types = { word: ['a', 'b', 'c'], pdf: [], plain: []}
  # types_to_mime_types = {}
  #
  # mime_types[self.type]

end
