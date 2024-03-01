class RemoveRoleFromAdmins < ActiveRecord::Migration[7.0]
  def change
    remove_column :admins, :role, :string
  end
end
