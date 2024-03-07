class AddOwnerNameToSubAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :sub_accounts, :owner_name, :string
  end
end
