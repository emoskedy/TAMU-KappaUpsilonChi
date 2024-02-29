class RemoveServicesAndOtherIncomeAndAddServicesAndOtherIncomeToChecks < ActiveRecord::Migration[7.0]
  def change
    remove_column :checks, :services, :decimal
    remove_column :checks, :other_income, :decimal
    add_column :checks, :services_and_other_income, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
