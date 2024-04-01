class AddRolesToAdmins < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :is_officer, :boolean, default: false unless column_exists?(:admins, :is_officer)

    return if column_exists?(:admins, :is_admin)

    add_column :admins, :is_admin, :boolean, default: false
  end
end
