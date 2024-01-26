namespace :download do
  desc "Download a file from the server"
  task :remote_to_local, [:file_id] => :environment do |_task, args|
    file_id = args[:file_id]
    document = Document.find_by(id: file_id)

    if document.present?
      file_data = document.file.download
      file_name = document.file.filename.to_s.split("/").last
      File.open(file_name, "wb") do |file|
        file.write(file_data)
      end
      puts "File downloaded successfully as '#{file_name}'"
    else
      puts "Error downloading file: File not found with ID #{file_id}"
    end
  end
end
