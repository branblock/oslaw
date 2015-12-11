require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { FactoryGirl.create(:post) }
  let(:user) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment, post: post, user: user) }

  it { should belong_to(:post) }
  it { should belong_to(:user) }

  it { should have_many(:votes) }

  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "should respond to body" do
      expect(comment).to respond_to(:body)
    end
  end
end
