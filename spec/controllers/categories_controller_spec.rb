require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }

  describe "GET index" do
    login_user
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    login_user
    it "returns http status success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "initializes @category" do
      get :new
      expect(assigns(:category)).not_to be_nil
    end
  end

  describe "POST create" do
    login_user
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, category: FactoryGirl.build(:category).attributes
        }.to change(Category, :count).by(1)
      end

      it "redirects to the categories index" do
        post :create, category: FactoryGirl.build(:category).attributes
        expect(response).to redirect_to(categories_path)
      end
    end

    context "with invalid params" do
      it "does not create a new Category" do
        expect {
          post :create, category: {name: "", description: ""}
        }.to_not change(Category, :count)
      end

      it "redirects to the categories index" do
        post :create, category: {name: "", description: ""}
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe "GET show" do
    login_user
    it "returns http success" do
      get :show, id: category.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: category.id
      expect(response).to render_template :show
    end

    it "assigns category to @category" do
      get :show, {id: category.id}
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET edit" do
    login_user
    it "returns http success" do
      get :edit, id: category.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, id: category.id
      expect(response).to render_template :edit
    end

    it "assigns category to be updated to @category" do
      get :edit, {id: category.id}
      category_instance = assigns(:category)

      expect(category_instance.id).to eq category.id
      expect(category_instance.name).to eq category.name
      expect(category_instance.description).to eq category.description
    end
  end
    #
  describe "PUT update" do
    login_user
    context "successfully updates category" do
      it "updates category with expected attributes" do
        new_name = "New Name"
        new_description = "New Description"

        put :update, id: category.id, category: {name: new_name, description: new_description}

        updated_category = assigns(:category)
        expect(updated_category.id).to eq category.id
        expect(updated_category.name).to eq new_name
        expect(updated_category.description).to eq new_description
      end

      it "redirects to the updated category" do
        new_name = "New Name"
        new_description = "New Description"

        put :update, id: category.id, category: {name: new_name, description: new_description}
        expect(response).to redirect_to category
        expect(flash[:notice]).to be_present
      end
    end

    context "unsuccessfully updates category" do
      it "renders the #edit view" do
        put :update, id: category.id, category: {name: "", description: ""}
        expect(response).to render_template :edit
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    it "destroys the category" do
      delete :destroy, id: category.id
      count = Category.where({id: category.id}).size
      expect(count).to eq 0
    end

    it "redirects to users #index view" do
      delete :destroy, id: category.id
      expect(response).to redirect_to users_path
      expect(flash[:notice]).to be_present
    end
  end
end
