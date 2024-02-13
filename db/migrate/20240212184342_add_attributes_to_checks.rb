class AddAttributesToChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :checks, :organization_name, :string
    add_column :checks, :account_number, :string
    add_column :checks, :date, :date
    add_column :checks, :payable_name, :string
    add_column :checks, :payable_phone_number, :string
    add_column :checks, :payable_address, :text
    add_column :checks, :payment_method, :string
    add_column :checks, :role, :string
    add_column :checks, :dollar_amounts, :decimal, array: true, default: [] 
  end
end
