class AddAdminIdToChecks < ActiveRecord::Migration[7.0]
  def change
    change_column :checks, :admin_id, :bigint, null: true
  end
end
