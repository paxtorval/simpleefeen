class AddCategoryRefToMovements < ActiveRecord::Migration[7.1]
  def change
    add_reference :movements, :category, null: true, foreign_key: true
  end
end
