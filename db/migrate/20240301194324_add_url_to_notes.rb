class AddUrlToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :avatar_url, :string
  end
end
