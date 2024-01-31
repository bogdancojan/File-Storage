class Document < ApplicationRecord
  has_one_attached :file

  validates :file, presence: true
  validate :file_size_under_5_mb

  private

  def file_size_under_5_mb
    if file.attached? && file.blob.byte_size > 5.megabytes
      errors.add(:file, "#{file.blob.filename} is too large (maximum is 5 MB)")
    end
  end
end
