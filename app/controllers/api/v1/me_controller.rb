class Api::V1::MeController < ApplicationController
    def index
      if current_user
          render json: @current_user, status: :ok
      else
          render json: {
              status: 401,
              message: "Couldn't find an active session."
            }, status: :unauthorized
      end
    end

    def balances 
      cash = Account.where(user_id: current_user ,account_type:"depository").sum(:current)
      debt = Account.where(user_id: current_user ,account_type:"credit").sum(:current)
      loans = Account.where(user_id: current_user ,account_type:"loan").sum(:current)
      investments = Account.where(user_id: current_user ,account_type:"investment").sum(:current)

      render json: {
        "cash": cash, 
        "debt": debt,
        "loans": loans,
        "investments": investments
      },status: :ok
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
