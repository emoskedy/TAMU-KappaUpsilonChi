class Check < ApplicationRecord
    before_validation :set_default_values

    validates :organization_name, presence: true
    validates :account_number, presence: true, numericality: { only_integer: true }
    validates :date, presence: true
    validates :payable_name, presence: true
    validates :payment_method, inclusion: { in: %w[direct_deposit mail_to_payee pick_up_at_sofc] }


    enum role: { student: 'student', employee: 'employee', not_affiliated: 'not_affiliated'}
    enum payment_method: { direct_deposit: 'direct_deposit', mail_to_payee: 'mail_to_payee', pick_up_at_sofc: 'pick_up_at_sofc' }

    def total_dollar_amount
        dollar_amounts.map(&:to_f).sum
    end


    private

    def set_default_values
        self.organization_name ||= 'Kappa Upsilon Chi'
        self.account_number ||= 945470
        self.payment_method ||= 'direct_deposit'
    end 
end