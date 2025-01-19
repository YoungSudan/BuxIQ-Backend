# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RackSessionsFix
  respond_to :json

  private
  def respond_with(current_user, _opts = {})
    # Call Plaid API to get accounts and transactions
    # PullAccountsJob.perform_now(current_user)
    # PullTransactionsJob.perform_now(current_user)
    if current_user
      render json: {
        status: { 
          code: 200, message: 'Logged in successfully.',
          data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
        }
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized  
    end
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end



  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
