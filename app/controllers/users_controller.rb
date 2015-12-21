class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_user, only: [:show, :destroy]
  before_action :set_all

  def index
    @posts = Post.all
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:notice] = "User has been deleted."
    redirect_to users_path
  end

  private
  def ready_user
    @user = User.find(params[:id])
  end

  def set_all
    @users = User.all
  end
end
