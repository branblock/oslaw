require 'rails_helper'

RSpec.describe CommentsController, type: :controller, focus: true do
  let(:my_category) { create(:category) }
  let(:my_post) { create(:post, category: my_category) }
  let(:my_comment) { create(:comment, post: my_post) }

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new comment" do
        expect{ post :create, format: :js, comment: attributes_for(:comment), post_id: my_post.id }.to change(Comment,:count).by(1)
      end

      it "returns http success" do
        post :create, format: :js, comment: attributes_for(:comment), post_id: my_post.id
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid attributes" do
      it "does not create a new comment" do
        expect{ post :create, format: :js, comment: attributes_for(:comment, body: nil), post_id: my_post.id }.to change(Comment,:count).by(0)
      end

      it "returns http success" do
        post :create, format: :js, comment: attributes_for(:comment, body: nil), post_id: my_post.id, category_id: my_category.id
        expect(response).to have_http_status(:success)
      end
    end
  end

  context "deletion for an admin user" do
    let(:user) { create(:user, role: 'admin') }

    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
        count = Comment.where({id: my_comment.id}).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
        expect(response).to have_http_status(:success)
      end
    end
  end
end
