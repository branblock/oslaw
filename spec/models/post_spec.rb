require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, category: category, user: user) }

  it { should have_many(:comments) }
  it { should have_many(:likes) }

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

  describe "liking" do
    let(:like) { FactoryGirl.create(:like, value: 1) }
    @likes = post.likes.where(value: 1)

    describe "#likes" do
      it "counts the number of votes with value = 1" do
        expect( post.likes ).to eq(@likes)
      end
    end

    describe "#total_likes" do
      it "returns the sum of all likes" do
        expect( post.likes ).to eq(@likes)
      end
    end

    describe "#update_rank" do
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq (post.total_likes + (post.created_at - Time.new(1970, 1, 1)) / 1.day.seconds )
      end

      it "updates the rank when a like is created" do
        old_rank = post.rank
        FactoryGirl.create(:like, value: 1)
        expect(post.rank).to eq (old_rank + 1)
      end
    end
  end
end
