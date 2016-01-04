require 'rails_helper'

RSpec.describe FavoritesController, type: :controller, focus: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:my_post) { FactoryGirl.create(:post, user: user) }

  describe 'POST create' do
  login_user
    it 'creates a favorite for the current user and specified post' do
      expect(user.favorites.find_by_post_id(my_post.id)).to be_nil
      post :create, format: :js, post_id: my_post.id
      expect(user.favorites.find_by_post_id(my_post.id)).not_to be_nil
    end

    it "returns http success" do
      post :create, format: :js, post_id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE destroy' do
  login_user
    it 'destroys the favorite for the current user and post' do
      favorite = user.favorites.where(post: my_post).create
      expect(user.favorites.find_by_post_id(my_post.id) ).not_to be_nil
      delete :destroy, format: :js, post_id: my_post.id, id: favorite.id
      expect(user.favorites.find_by_post_id(my_post.id) ).to be_nil
    end

    it "returns http success" do
      favorite = user.favorites.where(post: my_post).create
      delete :destroy, format: :js, post_id: my_post.id, id: favorite.id
      expect(response).to have_http_status(:success)
    end
  end
end
