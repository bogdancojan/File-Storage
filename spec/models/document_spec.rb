require 'rails_helper'

RSpec.describe Document, type: :model do
  it "is valid with a file attached" do
    document = Document.new
    document.file.attach(io: File.open('spec/fixtures/test_file.txt'), filename: 'test_file.txt', content_type: 'application/txt')
    expect(document).to be_valid
  end

  it "is not valid without a file attached" do
    document = Document.new
    expect(document).to_not be_valid
  end
end
