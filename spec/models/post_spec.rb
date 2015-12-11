require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, category: category, user: user) }

  it { should have_many(:comments) }
  it { should have_many(:votes) }

  it { should belong_to(:category) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:title).is_at_most(25) }
  it { should validate_length_of(:body).is_at_least(5) }
  it { should validate_length_of(:body).is_at_most(100) }

  describe "attributes" do
    it "should respond to title" do
      expect(post).to respond_to(:title)
    end

    it "should respond to body" do
      expect(post).to respond_to(:body)
    end
  end

  describe "voting" do
    let(:up_vote) { FactoryGirl.create_list(:up_vote, 3) }
    let(:down_vote) { FactoryGirl.create_list(:down_vote, 2) }

    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect( up_vote.count ).to eq(3)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect( down_vote.count ).to eq(2)
      end
    end

    describe "points" do
      it "returns the sum of all up votes and down votes" do
        expect( post.points ).to eq(up_vote.count - down_vote.count)
      end
    end

    describe "#update_rank" do
      it "calculates the correct rank" do
        post.update_rank
        expect(post.rank).to eq (post.points + (post.created_at - Time.new(1970, 1, 1)) / 1.day.seconds )
      end

      it "updates the rank when an up vote is created" do
        old_rank = post.rank
        FactoryGirl.create(:vote, value: 1)
        expect(post.rank).to eq (old_rank + 1)
      end

      it "updates the rank when a down vote is created" do
        old_rank = post.rank
        FactoryGirl.create(:vote, value: -1)
        expect(post.rank).to eq (old_rank - 1)
      end
    end
  end
end
