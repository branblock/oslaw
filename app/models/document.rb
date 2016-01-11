class Document < ActiveRecord::Base
  belongs_to :post

  has_attached_file :upload,
    url: ":s3_domain_url",
    path: "/uploads/:id/:filename"
  validates_attachment :upload,
    presence: true,
    content_type: { content_type: ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/pdf", "text/plain", "text/xml"] },
    size: { in: 0..8.megabytes }

  # For dowloading attachments from s3 storage
  def download_url(style_name=:original)
    upload.s3_bucket.objects[upload.s3_object(style_name).key].url_for(:read,
      :secure => true,
      :expires => 24*3600,  # 24 hours
      :response_content_disposition => "attachment; filename='#{upload_file_name}'").to_s
  end
end
