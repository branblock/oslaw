require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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

    it "renders the #show view" do
      get :show, {id: user.id}
      expect(response).to render_template :show
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

  context "deletion for an admin user" do
    describe "DELETE destroy" do
      login_user
      login_admin
      it "deletes the user" do
        delete :destroy, id: user.id
        count = User.where({id: user.id}).count
        expect(count).to eq 0
      end

      it "returns http success" do
        delete :destroy, id: user.id
        expect(response).to redirect_to(users_path)
        expect(flash[:notice]).to be_present
      end
    end
  end
end
