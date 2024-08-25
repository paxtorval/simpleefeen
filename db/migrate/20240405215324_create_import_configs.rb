class CreateImportConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :import_configs do |t|
      t.references :asset, null: false, foreign_key: true
      t.json :config

      t.timestamps
    end
  end
end
