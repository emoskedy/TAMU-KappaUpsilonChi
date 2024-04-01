class ChangeSubAccountIdNullConstraint < ActiveRecord::Migration[7.0]
  def change
    change_column_null :checks, :sub_account_id, true
  end
end
