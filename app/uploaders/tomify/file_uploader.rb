class Tomify::FileUploader < Tomify.base_uploader.constantize
  def filename
    "#{model.uuid}.#{file.extension}" if original_filename.present?
  end
end
