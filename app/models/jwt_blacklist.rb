# == Schema Information
#
# Table name: jwt_blacklists
#
#  id         :bigint           not null, primary key
#  jti        :string
#  exp        :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class JwtBlacklist < ApplicationRecord
    self.table_name = 'jwt_blacklists'

    def self.jwt_revoked?(jti)
      where(jti: jti).exists?
    end
end
