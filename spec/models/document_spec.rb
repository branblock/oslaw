require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:my_post) { FactoryGirl.create(:post) }
  let(:document) { FactoryGirl.create(:document, post: my_post) }

  it { should belong_to(:post) }

  it { should validate_presence_of(:upload) }

  it { should have_attached_file(:upload) }
  it { should validate_attachment_content_type(:upload).
    allowing('application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/pdf', 'text/plain', 'text/xml').
    rejecting('image/jpeg', 'image/gif', 'image/png') }
  it { should validate_attachment_size(:upload).
    less_than(8.megabytes) }

  describe "attributes" do
    it "should respond to upload" do
      expect(document).to respond_to(:upload)
    end
  end
end
