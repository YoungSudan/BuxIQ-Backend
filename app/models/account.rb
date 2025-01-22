# == Schema Information
#
# Table name: accounts
#
#  id            :bigint           not null, primary key
#  account_id    :string           not null
#  name          :string
#  official_name :string
#  user_id       :bigint           not null
#  available     :decimal(10, 2)
#  current       :decimal(10, 2)
#  limit         :decimal(10, 2)
#  currency_code :string
#  mask          :string
#  account_type  :string
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Account < ApplicationRecord
    belongs_to :user
    has_many :transactions

    def account_type
        type
    end

    def account_type_icon
        case account_type
        when "depository"
            "💰"
        when "credit"
            "💳"
        when "loan"
            "🏦"
        when "investment"
            "💸"
        end 
    end
end
