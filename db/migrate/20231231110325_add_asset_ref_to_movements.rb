class AddAssetRefToMovements < ActiveRecord::Migration[7.1]
  def change
    add_reference :movements, :asset, null: false, foreign_key: true
  end
end
