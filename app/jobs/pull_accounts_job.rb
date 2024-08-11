class PullAccountsJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Retrieve transactions for the last 30 days
    access_token = user.plaid_token # Replace with the actual access token

    accounts_get_request = Plaid::AccountsGetRequest.new
    accounts_get_request.access_token = access_token

    accounts_get_response = client.accounts_get(accounts_get_request)
    accounts = accounts_get_response.accounts

    # Process the transactions - For example, you can store them in your database
    if accounts
      # Process and store transactions as needed
      accounts.each do |account|
        # Handle each transaction (e.g., save it to your database)
        # Example:
        a = Account.create(
          user_id: user.id,
          account_id: account.account_id,
          current: account.balances.current,
          available: account.balances.available,
          currency_code: account.balances.iso_currency_code,
          name: account.name,
          official_name: account.official_name,
          account_type: account.type,
          subtype: account.subtype,
          limit: account.balances.limit
        )
        a.save!
      end
    else
      Rails.logger.error('No transactions found for the specified date range')
    end
  end

  private
  def client
    PlaidService.new.client
  end 

end

