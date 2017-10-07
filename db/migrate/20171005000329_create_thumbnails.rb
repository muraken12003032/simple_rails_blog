class CreateThumbnails < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      
      t.integer :blog_id
      t.integer :picture_id

      t.timestamps null: false
    end
  end
end
