require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:small_file) { Rack::Test::UploadedFile.new('spec/fixtures/small_file.txt', 'text/plain') }
  let(:large_file) { Rack::Test::UploadedFile.new('spec/fixtures/large_file.txt', 'text/plain') }

  before do
    File.write('spec/fixtures/small_file.txt', 'a' * 1.megabyte)
    File.write('spec/fixtures/large_file.txt', 'a' * 6.megabytes)
  end

  after do
    File.delete('spec/fixtures/small_file.txt')
    File.delete('spec/fixtures/large_file.txt')
  end

  it "is valid with a file attached" do
    document = Document.new
    document.file.attach(io: File.open('spec/fixtures/test_file.txt'), filename: 'test_file.txt', content_type: 'application/txt')
    expect(document).to be_valid
  end

  it "is not valid without a file attached" do
    document = Document.new
    expect(document).to_not be_valid
  end

  it 'validates that the file size is under 5 MB' do
    document = Document.new(file: small_file)
    expect(document).to be_valid

    document = Document.new(file: large_file)
    expect(document).not_to be_valid
    expect(document.errors.full_messages).to include("File large_file.txt is too large (maximum is 5 MB)")
  end
end
