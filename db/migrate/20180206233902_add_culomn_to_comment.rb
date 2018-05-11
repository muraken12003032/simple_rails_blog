class AddCulomnToComment < ActiveRecord::Migration
  def change
    add_column :comments, :name, :string
  end
end
