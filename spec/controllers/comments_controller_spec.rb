require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:my_post) { Post.create!(title: "Post Title", body: "Post Body") }
  let(:my_comment) { Comment.create!(body: "Comment Body", post: my_post) }

  describe "POST create" do
    it "increases the number of comments by 1" do
      expect{ post :create, post_id: my_post.id, comment: {body: "Comment Body"} }.to change(Comment,:count).by(1)
    end

    it "redirects to the post show view" do
      post :create, post_id: my_post.id, comment: {body: "Comment Body"}
      expect(response).to redirect_to [my_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the comment" do
      delete :destroy, post_id: my_post.id, id: my_comment.id
      count = Comment.where({id: my_comment.id}).count
      expect(count).to eq 0
    end

    it "redirects to the post show view" do
      delete :destroy, post_id: my_post.id, id: my_comment.id
      expect(response).to redirect_to [my_post]
    end
  end
end
