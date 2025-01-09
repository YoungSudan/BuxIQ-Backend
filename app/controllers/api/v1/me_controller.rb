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

    def monthly
      render json: current_user.monthly_spending, status: :ok
    end
end
