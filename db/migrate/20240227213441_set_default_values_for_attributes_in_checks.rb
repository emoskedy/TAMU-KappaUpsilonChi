class SetDefaultValuesForAttributesInChecks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :checks, :travel, from: nil, to: 0.0
    change_column_default :checks, :food, from: nil, to: 0.0
    change_column_default :checks, :office_supplies, from: nil, to: 0.0
    change_column_default :checks, :utilities, from: nil, to: 0.0
    change_column_default :checks, :membership, from: nil, to: 0.0
    change_column_default :checks, :clothing, from: nil, to: 0.0
    change_column_default :checks, :rent, from: nil, to: 0.0
    change_column_default :checks, :other_expenses, from: nil, to: 0.0
    change_column_default :checks, :items_for_resale, from: nil, to: 0.0
  end
end
