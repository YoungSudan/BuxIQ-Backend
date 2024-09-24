class Api::V1::AccountsController < ApplicationController
    def index
        render json: user.accounts
    end

    private
    def user
        if request.headers['Authorization'].present?
          jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise[:jwt_secret_key])
          u = User.find(jwt_payload[0]['sub'].to_i)
        else
          @u = nil
        end
        u
    end
end
