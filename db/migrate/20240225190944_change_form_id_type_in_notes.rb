class ChangeFormIdTypeInNotes < ActiveRecord::Migration[7.0]
  def change
    change_column :notes, :form_id, :bigint, unsigned: true, using: 'form_id::bigint'
  end
end
