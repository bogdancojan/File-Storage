require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:valid_attributes) {
    { file: fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test_file.txt'), 'application/txt'),
      name: 'test_file.txt' }
  }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #upload" do
    it "creates a new Document" do
      expect {
        post :upload, params: { file: valid_attributes[:file] }
      }.to change(Document, :count).by(1)
    end
  end

  describe "GET #download" do
    it "returns a success response" do
      document = Document.create! valid_attributes
      get :download, params: { id: document.to_param }
      expect(response).to be_successful
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested document" do
      document = Document.create! valid_attributes
      expect {
        delete :destroy, params: { id: document.to_param }
      }.to change(Document, :count).by(-1)
    end
  end
end
