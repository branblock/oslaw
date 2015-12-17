require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }
  let(:my_post) { FactoryGirl.create(:post, category: category) }

  describe "POST create" do
    login_user
    context "with valid params" do
      it "creates a new post" do
        expect {
          post :create, category_id: category.id, post: FactoryGirl.build(:post).attributes
        }.to change(Post, :count).by(1)
      end

      it "redirects to the new post" do
        post :create, category_id: category.id, post: FactoryGirl.build(:post).attributes
        expect(response).to redirect_to [category, Post.last]
      end
    end

    context "with invalid params" do
      it "does not create a new post" do
        expect {
          post :create, category_id: category.id, post: {title: "", body: ""}
        }.to_not change(Post, :count)
      end

      it "redirects to the #new view" do
        post :create, category_id: category.id, post: {title: "", body: ""}
        expect(response).to render_template :new
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "GET show" do
    login_user
    it "returns http success" do
      get :show, category_id: category.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, category_id: category.id, id: my_post.id
      expect(response).to render_template :show
    end

    it "assigns post to @post" do
      get :show, category_id: category.id, id: my_post.id
      expect(assigns(:post)).to eq(my_post)
    end
  end

  describe "GET new" do
    login_user
    it "returns http status success" do
      get :new, category_id: category.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, category_id: category.id, id: my_post.id
      expect(response).to render_template :new
    end

    it "initializes @post" do
      get :new, category_id: category.id, id: my_post.id
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "GET edit" do
    login_user
    it "returns http success" do
      get :edit, category_id: category.id, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, category_id: category.id, id: my_post.id
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, {category_id: category.id, id: my_post}
      post_instance = assigns(:post)

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  describe "PUT update" do
    login_user
    describe "successfully updates post" do
      it "updates post with expected attributes" do
        new_title = "New Title"
        new_body = "New Body"

        put :update, category_id: category.id, id: my_post.id, post: {title: new_title, body: new_body}

        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = "New Title"
        new_body = "New Body"

        put :update, category_id: category.id, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [category, my_post]
        expect(flash[:notice]).to be_present
      end
    end

  describe "unsuccessfully updates post" do
      it "redirects to the categories index" do
        put :update, category_id: category.id, id: my_post.id, post: {title: "", body: ""}
        expect(response).to render_template :edit
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe "DELETE destroy" do
    login_user
    it "destroys the post" do
      delete :destroy, category_id: category.id, id: my_post.id
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to category #show view" do
      delete :destroy, category_id: category.id, id: my_post.id
      expect(response).to redirect_to category_path
      expect(flash[:notice]).to be_present
    end
  end

  describe "PUT upvote" do
    login_user
    it "first vote increases number of post votes by one" do
      votes = my_post.get_upvotes.size
      put :upvote, category_id: category.id, id: my_post.id
      expect(my_post.get_upvotes.size).to eq(votes + 1)
    end

    it "second vote does not increase the number of votes" do
      put :upvote, category_id: category.id, id: my_post.id
      votes = my_post.get_upvotes.size
      put :upvote, category_id: category.id, id: my_post.id
      expect(my_post.get_upvotes.size).to eq(votes)
    end

    it "redirects to the post" do
      put :upvote, category_id: category.id, id: my_post.id
      expect(response).to redirect_to [my_post]
    end
  end

  describe "PUT downvote" do
    login_user
    it "first vote decreases number of post votes by one" do
      votes = my_post.get_downvotes.size
      put :downvote, category_id: category.id, id: my_post.id
      expect(my_post.get_downvotes.size).to eq(votes + 1)
    end

    it "second vote does not decrease the number of votes" do
      put :downvote, category_id: category.id, id: my_post.id
      votes = my_post.get_downvotes.size
      put :downvote, category_id: category.id, id: my_post.id
      expect(my_post.get_downvotes.size).to eq(votes)
    end

    it "redirects to the post" do
      put :downvote, category_id: category.id, id: my_post.id
      expect(response).to redirect_to [my_post]
    end
  end
end
