class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
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
      flash[:alert] = "There was an error saving the post."
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
      flash[:alert] = "There was an error updating the post."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been deleted."
    redirect_to [@post.category]
  end

  #upvote_from user
  #downvote_from user
  def upvote
    @post.upvote_from current_user
    redirect_to [@post]
  end

  def downvote
    @post.downvote_from current_user
    redirect_to [@post]
  end

  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

  def ready_post
    @post = Post.find(params[:id])
  end
end
