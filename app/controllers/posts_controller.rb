class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all

    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.order('created_at DESC')
    end
  end

  def show
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post has been saved."
      redirect_to [@post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    @categories = Category.find(params[:category_id])

    if @post.update_attributes(post_params)
      flash[:notice] = "Post has been updated."
      redirect_to posts_path
    else
      flash[:error] = "There was an error updating the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to posts_path
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ready_post
    @post = Post.find(params[:id])
  end
end
