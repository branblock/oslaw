require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: user) }

  it { should have_many(:comments) }
  it { should have_many(:documents) }
  it { should have_many(:bookmarks) }

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

  describe "orders of posts" do
    it "orders by ascending title" do
      alphabetical_first = FactoryGirl.create(:post, title: "Alpha", user: user)
      alphabetical_second = FactoryGirl.create(:post, title: "Betas", user: user)
      expect(Post.alphabetical).to eq [alphabetical_first, alphabetical_second]
    end

    it "orders by descending upvotes" do
      liked_first = FactoryGirl.create(:post, user: user, cached_votes_up: 6)
      liked_second = FactoryGirl.create(:post, user: user, cached_votes_up: 5)
      liked_third = FactoryGirl.create(:post, user: user, cached_votes_up: 4)
      liked_fourth = FactoryGirl.create(:post, user: user, cached_votes_up: 3)
      liked_fifth = FactoryGirl.create(:post, user: user, cached_votes_up: 2)
      liked_sixth = FactoryGirl.create(:post, user: user, cached_votes_up: 1)
      expect(Post.most_liked).to eq [liked_first, liked_second, liked_third, liked_fourth, liked_fifth]
    end

    it "orders by descending created_at date" do
      recent_first = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:00:00")
      recent_second = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:01:00")
      recent_third = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:02:00")
      recent_fourth = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:03:00")
      recent_fifth = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:04:00")
      recent_sixth = FactoryGirl.create(:post, user: user, created_at: "2015-01-01 12:05:00")
      expect(Post.most_recent).to eq [recent_sixth, recent_fifth, recent_fourth, recent_third, recent_second]
    end

    it "orders by date descending updated_at date" do
      updated_first = FactoryGirl.create(:post, user: user, updated_at: "2015-01-01 12:00:00")
      updated_second = FactoryGirl.create(:post, user: user, updated_at: "2015-01-01 12:01:00")
      updated_third = FactoryGirl.create(:post, user: user, updated_at: "2015-01-01 12:02:00")
      updated_fourth = FactoryGirl.create(:post, user: user, updated_at: "2015-01-01 12:03:00")
      updated_fifth = FactoryGirl.create(:post, user: user, updated_at: "2015-01-01 12:04:00")
      updated_sixth = FactoryGirl.create(:post, user: user, updated_at: "2015-01-01 12:05:00")
      expect(Post.updated).to eq [updated_sixth, updated_fifth, updated_fourth, updated_third, updated_second]
    end
  end
end
