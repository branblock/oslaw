class UsersController < ApplicationController
  before_action :ready_user, only: [:show, :destroy]

  def index
    @users = User.all
    @category = Category.new
    @categories = Category.all
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User has been deleted."
      redirect_to users_path
    else
      flash[:error] = "There was an error deleting the user."
      render :show
    end
  end

  private
  def ready_user
    @user = User.find(params[:id])
  end
end
