class AddAdminIdToChecks < ActiveRecord::Migration[7.0]
  def change
    add_reference :checks, :admin, null: false, foreign_key: true
  end
end
