class CreatePeople2 < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :address
      t.integer :uin
      t.integer :phone_number
      t.boolean :tamu_student
      t.boolean :tamu_employee
      t.boolean :not_affiliated

      t.timestamps
    end
  end
end