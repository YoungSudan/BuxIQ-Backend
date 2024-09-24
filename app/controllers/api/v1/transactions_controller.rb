class Api::V1::TransactionsController < ApplicationController
    def index
        @user = current_user
        render json: @user.transactions.limit(50)
    end
end


