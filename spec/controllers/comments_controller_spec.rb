require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:my_post) { create(:post) }
  let(:my_comment) { create(:comment, post: my_post) }
  let(:admin) { create(:user, factory: :admin_user) }

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new comment" do
        expect{ post :create, comment: attributes_for(:comment), post_id: my_post.id }.to change(Comment,:count).by(1)
      end

      it "redirects to the 'show' view" do
        post :create, comment: attributes_for(:comment), post_id: my_post.id
        expect(response).to redirect_to [my_post]
      end
    end

    context "with invalid attributes" do
      it "does not create a new comment" do
        expect{ post :create, comment: attributes_for(:comment, body: nil), post_id: my_post.id }.to change(Comment,:count).by(0)
      end

      it "redirects to the show view" do
        post :create, comment: attributes_for(:comment), post_id: my_post.id
        expect(response).to redirect_to [my_post]
      end
    end
  end

  describe "DELETE destroy" do
    it "deletes the comment" do
      delete :destroy, post_id: my_post.id, id: my_comment.id
      count = Comment.where({id: my_comment.id}).count
      expect(count).to eq 0
    end

    it "redirects to the show view" do
      delete :destroy, post_id: my_post.id, id: my_comment.id
      expect(response).to redirect_to [my_post]
    end
  end
end
