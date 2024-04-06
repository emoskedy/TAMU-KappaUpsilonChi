class AddAdminIdToChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :checks, :admin_id, :bigint, null: true unless column_exists?(:checks, :admin_id)

    return if column_exists?(:checks, :admin_id)

  end
end
