require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:my_post) { FactoryGirl.create(:post, user: user) }
  let(:tagged_post) { FactoryGirl.create(:post, :tags, user: user) }


  describe "GET index" do
    login_user
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    context "entire index" do
      it "assigns @posts to all posts" do
        get :index
        expect(assigns(:posts)).to eq([my_post])
      end
    end

    context "tagged posts" do
      it "assigns @posts to only the tagged posts" do
        get :index
        expect(assigns(:posts)).to include(tagged_post)
        expect(assigns(:posts)).to_not include(my_post)
      end
    end
  end

  describe "POST create" do
    login_user
    context "with valid params" do
      it "creates a new post" do
        expect {
          post :create, post: FactoryGirl.build(:post).attributes
        }.to change(Post, :count).by(1)
      end

      it "redirects to the new post" do
        post :create, post: FactoryGirl.build(:post).attributes
        expect(response).to redirect_to [Post.last]
      end
    end

    context "with invalid params" do
      it "does not create a new post" do
        expect {
          post :create, post: {title: "", body: ""}
        }.to_not change(Post, :count)
      end

      it "redirects to the #new view" do
        post :create, post: {title: "", body: ""}
        expect(response).to render_template :new
      end
    end
  end

  describe "GET show" do
    login_user
    it "returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, id: my_post.id
      expect(response).to render_template :show
    end

    it "assigns post to @post" do
      get :show, id: my_post.id
      expect(assigns(:post)).to eq(my_post)
    end
  end

  describe "GET new" do
    login_user
    it "returns http status success" do
      get :new, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, id: my_post.id
      expect(response).to render_template :new
    end

    it "initializes @post" do
      get :new, id: my_post.id
      expect(assigns(:post)).not_to be_nil
    end
  end

  describe "GET edit" do
    login_user
    it "returns http success" do
      get :edit, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, id: my_post.id
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, {id: my_post}
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

        put :update, id: my_post.id, post: {title: new_title, body: new_body}

        updated_post = assigns(:post)
        expect(updated_post.id).to eq my_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
      end

      it "redirects to the updated post" do
        new_title = "New Title"
        new_body = "New Body"

        put :update, id: my_post.id, post: {title: new_title, body: new_body}
        expect(response).to redirect_to [my_post]
        expect(flash[:notice]).to be_present
      end
    end

    describe "unsuccessfully updates post" do
      it "renders to the #edit view" do
        put :update, id: my_post.id, post: {title: "", body: ""}
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    login_admin
    it "destroys the post" do
      delete :destroy, id: my_post.id
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end


    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      expect(response).to redirect_to posts_path
      expect(flash[:notice]).to be_present
    end
  end

  describe "PUT upvote" do
    login_user
    it "first vote increases number of post votes by one" do
      votes = my_post.get_upvotes.size
      put :upvote, id: my_post.id
      expect(my_post.get_upvotes.size).to eq(votes + 1)
    end

    it "second vote does not increase the number of votes" do
      put :upvote, id: my_post.id
      votes = my_post.get_upvotes.size
      put :upvote, id: my_post.id
      expect(my_post.get_upvotes.size).to eq(votes)
    end

    it "redirects to the post" do
      put :upvote, id: my_post.id
      expect(response).to redirect_to [my_post]
    end
  end

  describe "PUT downvote" do
    login_user
    it "first vote decreases number of post votes by one" do
      votes = my_post.get_downvotes.size
      put :downvote, id: my_post.id
      expect(my_post.get_downvotes.size).to eq(votes + 1)
    end

    it "second vote does not decrease the number of votes" do
      put :downvote, id: my_post.id
      votes = my_post.get_downvotes.size
      put :downvote, id: my_post.id
      expect(my_post.get_downvotes.size).to eq(votes)
    end

    it "redirects to the post" do
      put :downvote, id: my_post.id
      expect(response).to redirect_to [my_post]
    end
  end
end
