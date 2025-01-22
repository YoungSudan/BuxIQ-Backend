# == Schema Information
#
# Table name: transactions
#
#  id                                 :bigint           not null, primary key
#  transaction_id                     :string
#  transaction_code                   :string
#  transaction_type                   :string
#  amount                             :decimal(10, 2)
#  currency_code                      :string
#  name                               :string
#  merchant_name                      :string
#  website                            :string
#  logo_url                           :string
#  payment_channel                    :string
#  pending                            :boolean
#  category_id                        :string
#  primary                            :string
#  detailed                           :string
#  personal_finance_category_icon_url :string
#  authorized_date                    :date
#  authorized_datetime                :datetime
#  created_at                         :datetime         not null
#  updated_at                         :datetime         not null
#  account_id                         :bigint
#

class Transaction < ApplicationRecord
    belongs_to :account
    has_one :category, through: :category_id    
    validates :transaction_id, uniqueness: true

    def month_name
        authorized_datetime.strftime("%B")
    end

    def year
        authorized_datetime.year
    end

    def month
        authorized_datetime.month
    end

    def category
        category.name
    end    
end
