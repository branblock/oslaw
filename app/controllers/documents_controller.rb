class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:destroy, :download]

  def create
    @post = Post.find(params[:post_id])
    @document = @post.documents.new(document_params)

    if @document.save
      redirect_to [@post]
    else
      flash[:alert] = "Document not added."
      redirect_to [@post]
    end
  end

  def destroy
    if @document.destroy
      redirect_to [@post]
    else
      flash[:alert] = "Document not deleted."
      redirect_to [@post]
    end
  end

  def download
    send_file(@document.upload.path)
  end

  private
  def document_params
    params.require(:document).permit(:upload)
  end

  def set_document
    @post = Post.find(params[:post_id])
    @document = @post.documents.find(params[:id])
  end
end
