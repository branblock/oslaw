class LikesController < ApplicationController
  before_action :authenticate_user!

  def like
    update_like(1)
    redirect_to :back
  end

  private

  def update_like(new_value)
    @post = Post.find(params[:post_id])
    @like = @post.likes.where(user_id: current_user.id).first

    if @like
      @like.update_attribute(:value, new_value)
    else
      @like = current_user.likes.create(value: new_value, post: @post)
    end
  end
end
