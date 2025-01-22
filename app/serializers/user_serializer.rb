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
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :first_name, :second_name
end
