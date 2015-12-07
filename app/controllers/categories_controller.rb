class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @user = User.find(params[:id])
    @category_user = @user
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.user = current_user

    if @category.save
      flash[:notice] = "Category has been saved."
      redirect_to categories_path
    else
      flash[:error] = "There was an error saving the category. Please try again."
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      flash[:notice] = "Category has been updated."
      redirect_to categories_path
    else
      flash[:error] = "There was an error updating the category. Please try again."
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      flash[:notice] = "Category has been deleted."
      redirect_to categories_path
    else
      flash[:error] = "There was an error deleting the category."
      render :show
    end
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
