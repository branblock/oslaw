class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :delete_word, :delete_pdf, :delete_plain]

  def index
    @posts = Post.all

    if params[:tag].present?
      @tagged_posts = @posts.tagged_with(params[:tag])
      @alphabetical_posts = @tagged_posts.order("title ASC").group_by{|u| u.title[0]}
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
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Post has been saved."
      redirect_to [@post]
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
      redirect_to [@post]
    else
      flash[:alert] = "There was an error updating the post."
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

  def delete_word
    @post.word_document = nil
    @post.save
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Word document has been removed.' }
        format.json { render :show, status: :ok, location: @post }
    end
  end

  def delete_pdf
    @post.pdf_document = nil
    @post.save
      respond_to do |format|
        format.html { redirect_to @post, notice: 'PDF has been removed.' }
        format.json { render :show, status: :ok, location: @post }
    end
  end

  def delete_plain
    @post.plain_document = nil
    @post.save
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Plain text has been removed.' }
        format.json { render :show, status: :ok, location: @post }
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :word_document, :pdf_document, :plain_document, :tag_list)
  end

  def ready_post
    @post = Post.find(params[:id])
  end
end
