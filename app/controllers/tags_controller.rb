class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :ready_tag, only: [:show, :destroy]

  def index
    @tags = ActsAsTaggableOn::Tag.all
    @alpha_tags = @tags.order(name: :asc)
  end

  def show
    @posts = Post.tagged_with(@tag.name)
  end

  def destroy
    if @tag.destroy
      flash[:notice] = "The tag has been deleted."
      redirect_to tags_path
    else
      flash[:alert] = "There was an error deleting the tag."
      redirect_to tags_path
    end
  end

  def ready_tag
    @tag =  ActsAsTaggableOn::Tag.find(params[:id])
  end
end
