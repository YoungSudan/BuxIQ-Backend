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
        DATE_TRUNC('month', authorized_date) AS month,
        COUNT(*) AS transaction_count,
        SUM(amount) AS total_amount
      FROM
        transactions
      WHERE 
        user_id = #{4}
      GROUP BY
        DATE_TRUNC('month', authorized_date)
      ORDER BY
        month;
    SQL
    
    results = Transaction.find_by_sql(query)
    
    # Iterate over the results and display the data
    # results.each do |result|
    #   puts "Month: #{result.month}"
    #   puts "Transaction Count: #{result.transaction_count}"
    #   puts "Total Amount: #{result.total_amount}"
    # end

    formatted_results = results.map do |month|
      {
        "name": month.month&.strftime('%B') || "No Date",
        "total": month.total_amount,
        #"transaction_count": month.transaction_count,
      }
    end
  end
end
