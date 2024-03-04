class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :picture
      t.bigint :form_id
      t.string :name
      t.string :avatar_url

      t.timestamps
    end
  end
end
