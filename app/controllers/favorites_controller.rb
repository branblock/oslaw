class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_post

  def create
    favorite = current_user.favorites.build(post: @post)
    favorite.save

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  private
  def ready_post
    @post = Post.find(params[:post_id])
  end
end
