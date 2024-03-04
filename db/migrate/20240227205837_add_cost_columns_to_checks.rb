class AddCostColumnsToChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :checks, :travel, :decimal, precision: 10, scale: 2
    add_column :checks, :food, :decimal, precision: 10, scale: 2
    add_column :checks, :office_supplies, :decimal, precision: 10, scale: 2
    add_column :checks, :utilities, :decimal, precision: 10, scale: 2
    add_column :checks, :membership, :decimal, precision: 10, scale: 2
    add_column :checks, :services, :decimal, precision: 10, scale: 2
    add_column :checks, :other_income, :decimal, precision: 10, scale: 2
    add_column :checks, :clothing, :decimal, precision: 10, scale: 2
    add_column :checks, :rent, :decimal, precision: 10, scale: 2
    add_column :checks, :other_expenses, :decimal, precision: 10, scale: 2
    add_column :checks, :items_for_resale, :decimal, precision: 10, scale: 2
  end
end
