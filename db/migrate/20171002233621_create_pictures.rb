class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      
      t.text :image, null: false
      t.string :alt
      t.integer :row_order

      t.timestamps null: false
    end
  end
end
