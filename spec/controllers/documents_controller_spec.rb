require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:my_post) { FactoryGirl.create(:post) }
  let(:document) { FactoryGirl.create(:document, post: my_post) }

  describe "POST create" do
    login_user
    context "with valid params" do
      it "creates a new document" do
        expect {
          post :create, post_id: my_post.id, document: FactoryGirl.create(:document).attributes
        }.to change(Document, :count).by(1)
      end

      it "redirects to the post" do
        post :create, post_id: my_post.id, document: FactoryGirl.build(:document).attributes
        expect(response).to redirect_to [my_post]
      end
    end

    context "with invalid params" do
      it "does not create a new document" do
        expect {
          post :create, post_id: my_post.id, document: {upload: ""}
        }.to_not change(Document, :count)
      end

      it "redirects to the post" do
        post :create, post_id: my_post.id, document: {upload: ""}
        expect(response).to redirect_to [my_post]
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    it "deletes the document" do
      delete :destroy, post_id: my_post.id, id: document.id
      count = Document.where({id: document.id}).count
      expect(count).to eq 0
      expect(response).to redirect_to [my_post]
    end

    it "redirects to the post" do
      delete :destroy, post_id: my_post.id, id: document.id
      expect(response).to redirect_to [my_post]
    end
  end
end
