class ChangeCurrencyType < ActiveRecord::Migration[7.1]
  def change
    change_column :movements, :original_amount, :float
    end
end
