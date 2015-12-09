class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @new_comment = Comment.new

    unless @comment.save
      flash.now[:alert] = "Comment was not added. Please try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    unless @comment.destroy
      flash.now[:alert] = "Comment was not deleted. Please try again."
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
