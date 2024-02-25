class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :picture
      t.string :form_id

      t.timestamps
    end
  end
end
