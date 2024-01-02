class ImportMovementsJob < ApplicationJob
  queue_as :default
  self.queue_name_prefix = 'import_movements'

  def perform(file, asset_id)
    excel_file = Roo::Spreadsheet.open(file)

    puts excel_file.info

    # TODO: user will need to specify the names of the columns in a config
    rows = excel_file.parse(movement_date: 'Fecha Oper', settled_date: 'Fecha Valor', concept: 'Concepto', description: 'Descripción', amount: 'Importe')

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
        ).save
      end
    end

    Rails.logger.info("File #{File.basename(file.path)} has been successfully imported")
  end
end
