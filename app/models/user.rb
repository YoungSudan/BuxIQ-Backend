# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  jti                    :string
#  plaid_token            :string
#
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :transactions
  has_many :accounts

  def total_expense_amount
  end

  def total_transaction_amount
    transactions.sum(:amount)
  end

  def monthly_spending
    query = <<-SQL
      SELECT
          DATE_TRUNC('month', authorized_datetime) AS month,
          COUNT(*) AS transaction_count,
          SUM(amount) AS total_amount
      FROM
          transactions
      WHERE 
          user_id = #{id}
          AND DATE_TRUNC('year', authorized_datetime) = '2024-01-01'
      GROUP BY
          month
      HAVING
          COUNT(*) > 1
      ORDER BY
        month
    SQL
    
    results = Transaction.find_by_sql(query)
    formatted_results = results.map do |month|
      {
        "month": month.month&.strftime('%B') || "No Date",
        "total": month.total_amount,
        "transaction_count": month.transaction_count,
      }
    end
    return formatted_results
  end
end
