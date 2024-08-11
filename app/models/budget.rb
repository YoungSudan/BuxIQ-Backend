# == Schema Information
#
# Table name: budgets
#
#  id                :bigint           not null, primary key
#  user_id           :bigint           not null
#  category_id       :bigint           not null
#  amout             :decimal(10, 2)
#  budget_start_date :date
#  budget_end_date   :date
#  reset_date        :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Budget < ApplicationRecord
end
