class ImportMovementsController < ApplicationController

  def import
    uploaded_file = params[:import_file]
    asset_id = params[:asset_id]

    Rails.logger.info("Uploaded file is #{uploaded_file.inspect}")

    import_job = ImportMovementsJob.new
    import_job.perform(uploaded_file.tempfile, asset_id)
  end
end
