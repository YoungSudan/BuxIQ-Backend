# == Schema Information
#
# Table name: accounts
#
#  id            :bigint           not null, primary key
#  account_id    :string           not null
#  name          :string
#  official_name :string
#  available     :decimal(10, 2)
#  current       :decimal(10, 2)
#  limit         :decimal(10, 2)
#  currency_code :string
#  mask          :string
#  subtype       :string
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
class Account < ApplicationRecord
    belongs_to :user

end
