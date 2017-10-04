class AddColumnToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :status, :boolean
  end
end
