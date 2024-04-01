class AddApprovalStatusAndCommentsToChecks < ActiveRecord::Migration[7.0]
  def change
    add_column :checks, :approval_status, :text
    add_column :checks, :comments, :text
  end
end
