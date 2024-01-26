class DocumentsController < ActionController::Base
  def index
    @documents = Document.all
  end

  def download
    document = Document.find(params[:id])
    send_data document.file.download, filename: document.file.filename.to_s, content_type: document.file.content_type
  end

  def upload
    file = params[:file]
    document = Document.new(file: file, name: file.original_filename)
    if document.save
      flash[:notice] = 'File uploaded successfully.'
    else
      flash[:alert] = "Error uploading file: #{document.errors.full_messages.join(', ')}"
    end
    redirect_to documents_path
  end

  def destroy
    document = Document.find(params[:id])
    document.file.purge
    if document.destroy
      flash[:notice] = 'Document and its file deleted successfully.'
    else
      flash[:alert] = "Error deleting document: #{document.errors.full_messages.join(', ')}"
    end
    redirect_to documents_path
  end
end
