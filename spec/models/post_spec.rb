require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, category: category, user: user) }

  it { should have_many(:comments) }

  it { should belong_to(:category) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "should respond to title" do
      expect(post).to respond_to(:title)
    end

    it "should respond to body" do
      expect(post).to respond_to(:body)
    end
  end
end
