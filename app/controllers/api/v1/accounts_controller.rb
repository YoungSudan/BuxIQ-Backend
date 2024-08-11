class Api::V1::AccountsController < ApplicationController
    def index
        @user = current_user
        render json: @user.accounts
    end
end
