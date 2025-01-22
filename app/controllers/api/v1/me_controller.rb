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

    def accounts
      render json: current_user.accounts, status: :ok
    end

    def transactions
      render json: current_user.transactions, status: :ok
    end

    def balances 
      render json: current_user.balances, status: :ok
    end

    def monthly_spending
      render json: current_user.monthly_spending(month: params[:month] || Time.now.month ), status: :ok
    end

    def yearly_spending
      render json: current_user.yearly_spending(year: params[:year] || nil), status: :ok
    end
end
