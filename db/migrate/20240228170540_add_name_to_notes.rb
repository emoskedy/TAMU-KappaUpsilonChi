class AddNameToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :name, :string
  end
end
