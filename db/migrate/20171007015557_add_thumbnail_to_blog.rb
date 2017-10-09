class AddThumbnailToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :picture_id, :integer
  end
end
