FactoryGirl.define do
  factory :document do
    upload_file_name { 'test.pdf' }
    upload_content_type { 'application/pdf' }
    upload_file_size { 1024 }
    post
  end
end
