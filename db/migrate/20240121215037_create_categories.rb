class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.text :name
      t.text :description
      t.string :bg_color
      t.string :text_color

      t.timestamps
    end
  end
end
