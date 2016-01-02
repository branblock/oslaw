class Document < ActiveRecord::Base
  belongs_to :post

  has_attached_file :upload
  validates_attachment :upload,
    presence: true,
    content_type: { content_type: ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/pdf"] },
    size: { in: 0..8.megabytes }

end
