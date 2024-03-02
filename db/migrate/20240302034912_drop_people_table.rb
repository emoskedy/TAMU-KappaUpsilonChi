class DropPeopleTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :people
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end