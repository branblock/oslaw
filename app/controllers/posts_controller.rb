class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :delete_document]

  def index
    @posts = Post.all

    if params[:tag].present?
      @tagged_posts = @posts.tagged_with(params[:tag]).order("title ASC").group_by{|u| u.title[0]}
    else
      @alphabetical_posts = @posts.order("title ASC").group_by{|u| u.title[0]}
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
      flash[:alert] = "Post has been saved."
      redirect_to [@post]
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)
    @post.document = params[:post][:document]

    if @post.save
      flash[:notice] = "Post has been updated."
      redirect_to [@post]
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been deleted."
    redirect_to action: :index
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

  #delete attachments
  def delete_document
    @post.document = nil
    @post.save
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Document has been removed.' }
        format.json { render :show, status: :ok, location: @post }
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :document, :tag_list)
  end

  def ready_post
    @post = Post.find(params[:id])
  end
end
