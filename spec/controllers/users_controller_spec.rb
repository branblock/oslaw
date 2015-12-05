require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #create hash of attributes to use in specs
  let (:new_user_attributes) do {
    first_name: "Stan",
    last_name: "User",
    username: "stanuser",
    email: "standarduser@example.com",
    password: "password",
    password_confirmation: "password",
    role: "standard"
  }
  end

  #test the new action for http success when issuing a GET
  describe "GET new" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :show
      expect(:user).to_not be_nil
    end
  end

  describe "POST create" do
  #test the create action for http success
    it "returns http success" do
      post :create, user: new_user_attributes
      expect(response).to have_http_status(:redirect)
    end

    #test that the database count on the users table increases by one when a POST is issued to create
    it "creates a new user" do
      expect{ post :create, user: new_user_attributes }.to change(User, :count).by(1)
    end

    #test that user.first_name is set properly when a user is created
    it "sets user first_name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).first_name).to eq new_user_attributes[:first_name]
    end

    #test that user.last_name is set properly when a user is created
    it "sets user last_name properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).last_name).to eq new_user_attributes[:last_name]
    end

    #test that user.username is set properly when a user is created
    it "sets user username properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).username).to eq new_user_attributes[:username]
    end

    #test that user.email is set properly when a user is created
    it "sets user email properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end

    #test that user.password is set properly when a user is created
    it "sets user password properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end

    #test that user.password_confirmation is set properly when a user is created
    it "sets user password_confirmation properly" do
      post :create, user: new_user_attributes
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end

    it "logs the user in after sign up" do
      post :create, user: new_user_attributes
      expect(session[:user_id]).to eq assigns(:user).id
    end
  end

  describe "not signed in" do
    let(:factory_user) { create(:user) }

    before do
      post :create, user: new_user_attributes
    end

    it "returns http success" do
      get :show, {id: factory_user.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: factory_user.id}
      expect(response).to render_template :show
    end

    it "assigns factory_user to @user" do
      get :show, {id: factory_user.id}
      expect(assigns(:user)).to eq(factory_user)
    end
  end
end
