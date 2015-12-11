require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:my_category) { FactoryGirl.create(:category) }
  let(:my_user) { FactoryGirl.create(:user) }
  let(:my_post) { FactoryGirl.create(:post, category: my_category, user: my_user) }
  let(:my_comment) { FactoryGirl.create(:comment) }
  let(:vote) { FactoryGirl.create(:vote, user: my_user, post: my_post, comment: my_comment) }

  context "signed in user" do
    before do
      sign_in :user
      sign_in :other_user
    end
  end

  describe "POST up_vote" do
    it "the user's first vote increases the post's number of votes by one" do
      votes = my_post.votes.count
      post :up_vote, post_id: my_post_id
      expect(my_post_votes.count).to eq(votes +1)
    end

    it "the user's second vote does not increase the number of votes" do
      post :up_vote, post_id: my_post.id
      votes = my_post.votes.count
      post :up_vote, post_id: my_post.id
      expect(my_post.votes.count).to eq(votes)
    end

    it "increases the sum of post votes by one" do
      points = my_post.points
      post :up_vote, post_id: my_post.id
      expect(my_post.points).to eq(points + 1)
    end

    it ":back redirects to posts show page" do
      request.env["HTTP_REFERER"] = category_post_path(my_category, my_post)
      post :up_vote, post_id: my_post.id
      expect(response).to redirect_to([my_category, my_post])
    end

    it ":back redirects to posts category show" do
      request.env["HTTP_REFERER"] = category_path(my_category)
      post :up_vote, post_id: my_post.id
      expect(response).to redirect_to(my_category)
    end
  end

  describe "POST down_vote" do
    it "the users first vote increases number of post votes by one" do
      votes = my_post.votes.count
      post :down_vote, post_id: my_post.id
      expect(my_post.votes.count).to eq(votes + 1)
    end

    it "the users second vote does not increase the number of votes" do
      post :down_vote, post_id: my_post.id
      votes = my_post.votes.count
      post :down_vote, post_id: my_post.id
      expect(my_post.votes.count).to eq(votes)
    end

    it "decreases the sum of post votes by one" do
      points = my_post.points
      post :down_vote, post_id: my_post.id
      expect(my_post.points).to eq(points - 1)
    end

    it ":back redirects to posts show page" do
      request.env["HTTP_REFERER"] = category_post_path(my_category, my_post)
      post :down_vote, post_id: my_post.id
      expect(response).to redirect_to([my_category, my_post])
    end

    it ":back redirects to posts category show" do
      request.env["HTTP_REFERER"] = category_path(my_category)
      post :down_vote, post_id: my_post.id
      expect(response).to redirect_to(my_category)
    end
  end
end
