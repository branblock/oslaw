class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      flash[:notice] = "Category has been saved."
      redirect_to users_path
    else
      flash[:error] = "There was an error saving the category. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @category.assign_attributes(category_params)

    if @category.update_attributes(category_params)
      flash[:notice] = "Category has been updated."
      redirect_to users_path
    else
      flash[:error] = "There was an error updating the category. Please try again."
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Category has been deleted."
      redirect_to users_path
    else
      flash[:error] = "There was an error deleting the category."
      render :show
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end

  def ready_category
    @category = Category.find(params[:id])
  end
end
