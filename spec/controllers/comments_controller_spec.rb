require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }
  let(:my_post) { FactoryGirl.create(:post, category: category) }
  let(:comment) { FactoryGirl.create(:comment, post: my_post) }

  describe "POST create" do
    login_user
    context "with valid params" do
      it "creates a new comment" do
        expect {
          post :create, format: :js, post_id: my_post.id, comment: FactoryGirl.build(:comment).attributes
        }.to change(Comment, :count).by(1)
      end

      it "returns http success" do
        post :create, format: :js, post_id: my_post.id, comment: FactoryGirl.build(:comment).attributes
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to be_present
      end
    end

    context "with invalid params" do
      it "does not create a new comment" do
        expect {
          post :create, format: :js, post_id: my_post.id, comment: {body: ""}
        }.to_not change(Comment, :count)
      end

      it "returns http success" do
        post :create, format: :js, post_id: my_post.id, comment: {body: ""}
        expect(response).to have_http_status(:success)
        expect(flash[:alert]).to be_present
      end
    end
  end

  context "deletion for an admin user" do
    let(:user) { create(:user, role: 'admin') }

    login_user
    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, format: :js, post_id: my_post.id, id: comment.id
        count = Comment.where({id: comment.id}).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, format: :js, post_id: my_post.id, id: comment.id
        expect(response).to have_http_status(:success)
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "PUT upvote" do
    login_user
    it "first vote increases number of post votes by one" do
      votes = comment.get_upvotes.size
      put :upvote, post_id: my_post.id, id: comment.id
      expect(comment.get_upvotes.size).to eq(votes + 1)
    end

    it "second vote does not increase the number of votes" do
      put :upvote, post_id: my_post.id, id: comment.id
      votes = comment.get_upvotes.size
      put :upvote, post_id: my_post.id, id: comment.id
      expect(comment.get_upvotes.size).to eq(votes)
    end

    it "redirects to the post" do
      put :upvote, post_id: my_post.id, id: comment.id
      expect(response).to redirect_to [category, my_post]
    end
  end

  describe "PUT downvote" do
    login_user
    it "first vote decreases number of post votes by one" do
      votes = comment.get_downvotes.size
      put :downvote, post_id: my_post.id, id: comment.id
      expect(comment.get_downvotes.size).to eq(votes + 1)
    end

    it "second vote does not decrease the number of votes" do
      put :downvote, post_id: my_post.id, id: comment.id
      votes = comment.get_downvotes.size
      put :downvote, post_id: my_post.id, id: comment.id
      expect(comment.get_downvotes.size).to eq(votes)
    end

    it "redirects to the post" do
      put :downvote, post_id: my_post.id, id: comment.id
      expect(response).to redirect_to [category, my_post]
    end
  end
end
