require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin) }

  describe "after sign in for user" do
    login_user
    it "should allow access and go to user page" do
      redirect_to user_path(user)
    end
  end

  describe "after sign in for admin user" do
    it "should allow access" do
      redirect_to users_path(admin)
    end
  end
end
