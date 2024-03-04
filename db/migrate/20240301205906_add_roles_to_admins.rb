class AddRolesToAdmins < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:admins, :is_officer)
      add_column :admins, :is_officer, :boolean, default: false
    end
    
    unless column_exists?(:admins, :is_admin)
      add_column :admins, :is_admin, :boolean, default: false
    end
  end
end