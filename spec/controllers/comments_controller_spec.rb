require 'rails_helper'

RSpec.describe CommentsController, type: :controller, focus: true do
  let(:my_post) { FactoryGirl.create(:post) }
  let(:comment) { FactoryGirl.create(:comment, post: my_post) }


  context "with valid params" do
    let(:valid_comment) { post :create, format: :js, post_id: my_post.id, comment: FactoryGirl.build(:comment).attributes }
    login_user
    describe "POST create" do
      it "creates a new comment" do
        expect { valid_comment }.to change(Comment, :count).by(1)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "with invalid params" do
    let(:subject_comment) { post :create, format: :js, post_id: my_post.id, comment: { body: "" } }
    login_user
    describe "POST create" do
      it "does not create a new comment" do
        expect { subject_comment }.to_not change(Comment, :count)
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "admin user deleting comment" do
    login_admin
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

  context "user upvoting a comment" do
    login_user
    describe "PUT upvote" do
      it "first vote increases number of post votes by one" do
        put :upvote, format: :js, post_id: my_post.id, id: comment.id
        votes = comment.get_upvotes.size
        expect(votes + 1).to eq(votes + 1)
      end

      it "second vote does not increase the number of votes" do
        put :upvote, format: :js, post_id: my_post.id, id: comment.id
        votes = comment.get_upvotes.size
        put :upvote, format: :js, post_id: my_post.id, id: comment.id
        expect(votes).to eq(votes)
      end

      it "returns http success" do
        put :upvote, format: :js, post_id: my_post.id, id: comment.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "user downvoting a comment" do
    login_admin
    describe "PUT downvote" do
      it "first vote decreases number of post votes by one" do
        votes = comment.get_downvotes.size
        put :downvote, format: :js, post_id: my_post.id, id: comment.id
        expect(votes + 1).to eq(votes + 1)
      end

      it "second vote does not decrease the number of votes" do
        put :downvote, format: :js, post_id: my_post.id, id: comment.id
        votes = comment.get_downvotes.size
        put :downvote, format: :js, post_id: my_post.id, id: comment.id
        expect(comment.get_downvotes.size).to eq(votes)
      end

      it "returns http success" do
        put :downvote, format: :js, post_id: my_post.id, id: comment.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end
