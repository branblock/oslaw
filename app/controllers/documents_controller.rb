class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @document = @post.documents.new(document_params)

    if @document.save
      flash[:notice] = "Document added."
      redirect_to [@post]
    else
      flash[:alert] = "Document not added."
      redirect_to [@post]
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @document = @post.documents.find(params[:id])

    if @document.destroy
      flash[:notice] = "Document deleted."
      redirect_to [@post]
    else
      flash[:alert] = "Document not deleted."
      redirect_to [@post]
    end
  end

  private
  def document_params
    params.require(:document).permit(:upload)
  end
end
