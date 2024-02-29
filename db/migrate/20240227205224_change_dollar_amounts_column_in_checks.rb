class ChangeDollarAmountsColumnInChecks < ActiveRecord::Migration[7.0]
  def change
    remove_column :checks, :dollar_amounts
    add_column :checks, :dollar_amount, :decimal, precision: 10, scale: 2
  end
end
