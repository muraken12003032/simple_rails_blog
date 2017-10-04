class AddStatusToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :status, :boolean, default: false
  end
end
