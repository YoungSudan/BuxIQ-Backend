# == Schema Information
#
# Table name: categories
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  sub_category      :string
#  plaid_category_id :string
#  description       :text             not null
#  plaid_hierarchy   :text             default([]), is an Array
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Category < ApplicationRecord
    validates :sub_category, uniqueness: true

end
