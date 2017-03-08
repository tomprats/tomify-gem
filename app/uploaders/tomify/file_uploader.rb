class Tomify::FileUploader < Tomify.uploaders.base
  def filename
    "#{model.uuid}.#{file.extension}" if original_filename.present?
  end
end
