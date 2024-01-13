class ImportMovementsJob < ApplicationJob
  class MissingHeaderError < StandardError; end

  class InvalidRecordError < StandardError; end
  class InvalidFileError < StandardError; end

  queue_as :default
  self.queue_name_prefix = 'import_movements'

  discard_on CommonErrors::InvalidArguments do |job, error|
    Rails.logger.error('Invalid arguments')
    Rails.logger.error(error.message)
    Rails.logger.info("Discarded #{job.class} with id #{job.job_id}")
  end

  discard_on MissingHeaderError do |job, error|
    Rails.logger.error('A header in the file could not be found')
    Rails.logger.error(error.message)
    Rails.logger.info("Discarded #{job.class} with id #{job.job_id}")
  end

  discard_on InvalidRecordError do |job, error|
    Rails.logger.error('Invalid record in the file')
    Rails.logger.error(error.message)
    Rails.logger.info("Discarded #{job.class} with id #{job.job_id}")
  end

  discard_on InvalidFileError do |job, error|
    Rails.logger.error('Invalid file type')
    Rails.logger.error(error.message)
    Rails.logger.info("Discarded #{job.class} with id #{job.job_id}")
  end


  def invalid_parameters?(file_path, asset_id)
    file_path.nil? || asset_id.nil?
  end

  def perform(file, asset_id)
    raise CommonErrors::InvalidArguments.new if invalid_parameters?(file, asset_id)

    begin
      excel_file = Roo::Spreadsheet.open(file)

      puts excel_file.info
      # TODO: user will need to specify the names of the columns in a config
      rows = excel_file.parse(
        movement_date: 'Fecha Oper',
        settled_date: 'Fecha Valor',
        concept: 'Concepto',
        description: 'Descripción',
        amount: 'Importe'
      )

      Rails.logger.info "Going to import #{rows} rows"

      Movement.transaction do
        rows.each do |row|
          Movement.new(
            concept: row[:concept],
            description: row[:description],
            original_amount: row[:amount],
            original_currency: 'EUR', # TODO: get the currency from asset seems better
            movement_date: row[:movement_date],
            settled_date: row[:settled_date],
            asset_id: asset_id
          ).save!
        end
      end

      Rails.logger.info("File #{file} has been successfully imported")
    rescue ArgumentError => e
      raise InvalidFileError.new(e.message)
    rescue Roo::HeaderRowNotFoundError => e
      raise MissingHeaderError.new(e.message)
    rescue ActiveRecord::RecordInvalid => e
      raise InvalidRecordError.new(e.message)
    end
  end
end
