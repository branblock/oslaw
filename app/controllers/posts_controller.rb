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
    @user = @post.user
  end

  def new
    @category = Category.find(params[:category_id])
    @post = Post.new
  end

  def create
    @category = Category.find(params[:category_id])
    @post = @category.posts.build(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post has been saved."
      redirect_to [@category, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post has been updated."
      redirect_to [@post.category, @post]
    else
      flash[:error] = "There was an error updating the post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to [@post.category]
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

  def liked
    @post = Post.find(params[:id])
    @post.user = current_user

    if @post.user.like(@post)
      flash[:notice] = "Post has been deleted."
      redirect_to [@post.category]
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end      
  end
end
