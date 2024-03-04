class CreateSubAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :sub_accounts do |t|
      t.integer :sub_account_number

      t.timestamps
    end
  end
end
