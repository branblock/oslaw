class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)

    if comment.save
      flash[:notice] = "Comment was added."
      redirect_to [@post]
    else
      flash[:error] = "Comment was not added. Please try again."
      redirect_to [@post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    if comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@post]
    else
      flash[:error] = "Comment was not deleted. Please try again."
      redirect_to [@post]
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
