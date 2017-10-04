class RemoveColumnToBlog < ActiveRecord::Migration
  def change
    remove_column :blogs, :status
  end
end
