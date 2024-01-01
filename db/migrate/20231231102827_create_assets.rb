class CreateAssets < ActiveRecord::Migration[7.1]
  def change
    create_table :assets do |t|
      t.integer :kind
      t.string :country
      t.string :currency
      t.text :name
      t.text :description

      t.timestamps
    end
  end
end
