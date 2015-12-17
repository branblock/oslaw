class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @user = @category.user(params[:id])
    @posts = @category.posts
    @alphabetical_posts = @posts.alphabetical
    @popular_posts = @posts.most_liked
    @recent_posts = @posts.most_recent
    @updated_posts = @posts.updated
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
      flash[:alert] = "There was an error saving the category."
      redirect_to users_path
    end
  end

  def edit
  end

  def update
    @category.assign_attributes(category_params)

    if @category.update_attributes(category_params)
      flash[:notice] = "Category has been updated."
      redirect_to category_path
    else
      flash[:alert] = "There was an error updating the category."
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category has been deleted."
    redirect_to users_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :description)
  end

  def ready_category
    @category = Category.find(params[:id])
  end
end
