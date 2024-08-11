class JwtToken
    def self.encode(payload)
      JWT.encode(payload, Rails.application.credentials.devise[:jwt_secret_key])
    end
  
    def self.decode(token)
      JWT.decode(token, Rails.application.credentials.devise[:jwt_secret_key]).first
    end
end