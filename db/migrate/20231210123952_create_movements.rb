class CreateMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :movements do |t|
      t.string :concept
      t.string :description
      t.integer :original_amount
      t.string :original_currency
      t.date :movement_date
      t.date :settled_date

      t.timestamps
    end
  end
end
