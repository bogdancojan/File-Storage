require 'rack/test'

namespace :upload do
  desc "Upload a file to the server"
  task :local_to_remote, [:file_path] => :environment do |_task, args|
    if File.exist?(args[:file_path])
      file = Rack::Test::UploadedFile.new(args[:file_path], "application/octet-stream")
      document = Document.new(file: file, name: File.basename(args[:file_path]))
      if document.save
        puts "File uploaded successfully!"
      else
        puts "Error uploading file: #{document.errors.full_messages}"
      end
    else
      puts "Error uploading file: File not found at '#{args[:file_path]}'"
    end
  end
end
