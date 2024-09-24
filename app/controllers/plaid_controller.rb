require_dependency 'plaid_service'

class PlaidController < ApplicationController
    #skip_before_action :verify_authenticity_token

    def create_link_token
        # Create a link_token for the given user
        
        request = Plaid::LinkTokenCreateRequest.new(
            {
                user: { client_user_id: current_user.id.to_s },
                client_name: 'BuxIQ',
                products: ['transactions'],
                country_codes: ['CA'],
                language: "en",
                redirect_uri: 'http://localhost:3000/',
            }
        )

        response = client.link_token_create(request)
        puts(response)
        render json: response.to_json
    end 

    def exchange_public_token 
        
        request = Plaid::ItemPublicTokenExchangeRequest.new(
            {
              public_token: params[:data][:public_token]
            }
          )
          response = client.item_public_token_exchange(request)
          
          # These values should be saved to a persistent database and
          # associated with the currently signed-in user
          access_token = response.access_token
          item_id = response.item_id
        
          #user.update!(plaid_token:access_token, plaid_item_id: item_id)

          user.update!(plaid_token:access_token)
          PullTransactionsJob.perform_now(user)
          PullAccountsJob.perform_now(user)
          
          head :ok
    end

    def redirect
    end

    def trasnaction_sync_webhook
    end

    private 
    
    def client 
        PlaidService.new.client
    end

    def user
        if params['headers']['Authorization'].split[1].present?
          jwt_payload = JWT.decode(params['headers']['Authorization'].split[1], Rails.application.credentials.devise[:jwt_secret_key])
          u = User.find(jwt_payload[0]['sub'].to_i)
        else
          @u = nil
        end
        u
    end
end
