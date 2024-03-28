class AddAdminIdToChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :checks, :admin_id, :bigint, null: true
  end
end
