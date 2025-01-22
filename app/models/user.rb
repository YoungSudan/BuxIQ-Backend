# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  second_name            :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  plaid_token            :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  jti                    :string
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :accounts
  has_many :transactions, through: :accounts
  

  def total_expense_amount
    transactions.expenses.sum(:amount)
  end

  def total_transaction_amount
    transactions.sum(:amount)
  end

  def monthly_spending(month: 1)
    transactions
      .where(month: month)
      .group(:category)
      .sum(:amount)
      .transform_keys(&:to_s)
  end

  def balances(month: 1)      
    balances = accounts
      .group(:account_type)
      .sum(:current)
      .transform_keys(&:to_sym)

    cash = balances[:depository] || 0
    debt = balances[:credit] || 0 
    loans = balances[:loan] || 0
    investments = balances[:investment] || 0

    {
      "cash": cash, 
      "debt": debt,
      "loans": loans,
      "investments": investments
    }
  end

  def yearly_spending(year: '2024')
    transactions.where(
      "EXTRACT(year FROM authorized_datetime) = ?", 
      year
    ).group_by { |t| t.authorized_datetime.strftime('%B') }
     .transform_values do |txns|
        {
          month: txns.first.authorized_datetime.strftime('%B'),
          total: txns.sum(&:amount),
          transaction_count: txns.count
        }
      end.values
  end
end
