class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :uin
      t.string :phone_number
      t.string :affiliation 
      t.timestamps
    end
  end
end