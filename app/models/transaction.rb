# == Schema Information
#
# Table name: transactions
#
#  id                                 :bigint           not null, primary key
#  transaction_id                     :string
#  transaction_code                   :string
#  transaction_type                   :string
#  account_id                         :string
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
#  user_id                            :bigint           not null
#
class Transaction < ApplicationRecord
    belongs_to :user
    validates :transaction_id, uniqueness: true
end
