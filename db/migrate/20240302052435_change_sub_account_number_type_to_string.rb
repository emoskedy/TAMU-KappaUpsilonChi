class ChangeSubAccountNumberTypeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :sub_accounts, :sub_account_number, :string
  end
end
