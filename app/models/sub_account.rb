class SubAccount < ApplicationRecord
  has_many :checks

  validates :sub_account_number, presence: true
  validates :owner_name, presence: true
end
