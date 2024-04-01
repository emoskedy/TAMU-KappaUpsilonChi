class ChangeSubAccountNumberToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :sub_accounts, :sub_account_number, :bigint, unsigned: true
  end
end
