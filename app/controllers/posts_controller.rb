class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @posts = Post.all

    if params[:tag].present?
      @tagged_posts = @posts.tagged_with(params[:tag]).alphabetical.group_by{ |post| post.title[0].downcase }
    else
      @alphabetical_posts = @posts.alphabetical.group_by { |post| post.title[0].downcase }
    end
  end

  def show
    @user = @post.user(params[:id])
    @current_user = current_user
  end

  def new
    @post = Post.new
    @post.user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Page has been saved."
      redirect_to [@post]
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Page has been updated."
      redirect_to [@post]
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Page has been deleted."
    redirect_to action: :index
  end

  #upvote_from user
  #downvote_from user
  def upvote
    @post.upvote_from current_user
    @post.points

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def downvote
    @post.downvote_from current_user
    @post.points

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :upload, :tag_list)
  end

  def ready_post
    @post = Post.find(params[:id])
  end
end
