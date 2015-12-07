require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:my_category) { create(:category) }

  context "admin user" do
    let(:user) { create(:user, role: 'admin') }

    describe "GET index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Category.all to category" do
        get :index
        expect(assigns(:categories)).to eq([my_category])
      end
    end

    describe "GET show" do
      it "returns http success" do
        get :show, {id: my_category.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_category.id}
        expect(response).to render_template :show
      end

      it "assigns my_category to @category" do
        get :show, {id: my_category.id}
        expect(assigns(:category)).to eq(my_category)
      end
    end

    describe "GET new" do
      it "returns http success" do
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
      it "increases the number of categories by 1" do
        expect{ post :create, category: attributes_for(:category) }.to change(Category,:count).by(1)
      end

      it "assigns Category.last to @category" do
        post :create, category: attributes_for(:category)
        expect(assigns(:category)).to eq Category.last
      end

      it "redirects to the new category" do
        post :create, category: attributes_for(:category)
        expect(response).to redirect_to Category.last
      end
    end

    describe "GET edit" do
      it "returns http success" do
        get :edit, {id: my_category.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: my_category.id}
        expect(response).to render_template :edit
      end

      it "assigns category to be updated to @category" do
        get :edit, {id: my_category.id}
        category_instance = assigns(:category)

        expect(category_instance.id).to eq my_category.id
        expect(category_instance.name).to eq my_category.name
        expect(category_instance.description).to eq my_category.description
      end
    end

    describe "PUT update" do
      it "updates category with expected attributes" do
        new_name = { Faker::Lorem.words(rand(2..5)).join(' ') }
        new_description = { Faker::Lorem.sentence }

        put :update, id: my_category.id, category: {name: new_name, description: new_description}

        updated_category = assigns(:category)
        expect(updated_category.id).to eq my_category.id
        expect(updated_category.name).to eq new_name
        expect(updated_category.description).to eq new_description
      end

      it "redirects to the updated category" do
        new_name = { Faker::Lorem.words(rand(2..5)).join(' ') }
        new_description = { Faker::Lorem.sentence }

        put :update, id: my_category.id, category: {name: new_name, description: new_description}
        expect(response).to redirect_to my_category
      end
    end

    describe "DELETE destroy" do
      it "deletes the category" do
        delete :destroy, {id: my_category.id}
        count = Category.where({id: my_category.id}).size
        expect(count).to eq 0
      end

      it "redirects to categories index" do
        delete :destroy, {id: my_category.id}
        expect(response).to redirect_to categories_path
      end
    end
  end
end
