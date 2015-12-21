require 'rails_helper'

RSpec.describe ApplicationController, type: :controller, focus: true do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "user logging in" do
    login_user
    it "has a current_user" do
      subject.current_user.should_not be_nil
    end

    it "returns http success" do
      get :show, {id: user.id}
      expect(response).to have_http_status(:success)
    end

    it "redirects to the user's page" do
      get :show, {id: user.id}
      expect(response).to_render [current_user_path]
    end
  end

  describe "admin logging in" do
    login_admin
    it "has a current_user" do
      subject.current_user.should_not be_nil
    end

    it "returns http success" do
      get :index, {id: admin.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #index view" do
      get :index, {id: admin.id}
      expect(response).to render_template :index
    end
  end
end
