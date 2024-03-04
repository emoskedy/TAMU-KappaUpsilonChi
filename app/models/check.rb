class Check < ApplicationRecord
    before_validation :set_default_values
    before_save :calculate_dollar_amount
    before_update :reset_status_to_pending, if: -> { approval_status_was == 'denied' }

    belongs_to :admin
    belongs_to :sub_account, optional: true

    validates :organization_name, presence: true
    validates :account_number, presence: true, numericality: { only_integer: true }
    validates :date, presence: true
    validates :payable_name, presence: true
    validates :payment_method, inclusion: { in: %w[direct_deposit mail_to_payee pick_up_at_sofc] }
    validates :sub_account_id, presence: true, allow_nil: true


    enum role: { student: 'student', employee: 'employee', not_affiliated: 'not_affiliated'}
    enum payment_method: { direct_deposit: 'direct_deposit', mail_to_payee: 'mail_to_payee', pick_up_at_sofc: 'pick_up_at_sofc' }
    enum approval_status: { pending: 'Pending', approved: 'Approved', denied: 'Denied'}

    def total_dollar_amount
        dollar_amounts.map(&:to_f).sum
    end

    def reset_status_to_pending
        self.approval_status = 'pending'
    end


    private

    def set_default_values
        self.organization_name ||= 'Kappa Upsilon Chi'
        self.account_number ||= 945470
        self.payment_method ||= 'direct_deposit'
        self.approval_status ||= 'Pending'
    end 

    def calculate_dollar_amount
        self.dollar_amount = travel.to_f + food.to_f + office_supplies.to_f + utilities.to_f + membership.to_f + services_and_other_income.to_f + clothing.to_f + rent.to_f + other_expenses.to_f + items_for_resale.to_f
    end

end