class PullTransactionsJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    # Get the last 30 days' date range
    start_date = (Date.today - 30).strftime('%Y-%m-%d')
    end_date = Date.today.strftime('%Y-%m-%d')

    # Retrieve transactions for the last 30 days
    access_token = user.plaid_token # Replace with the actual access token

    transactions_get_request = Plaid::TransactionsGetRequest.new
    transactions_get_request.access_token = access_token
    transactions_get_request.start_date = start_date
    transactions_get_request.end_date = end_date

    transaction_response = client.transactions_get(transactions_get_request)
    transactions = transaction_response.transactions

    # Process the transactions - For example, you can store them in your database
    if transactions
      # Process and store transactions as needed
      transactions.each do |transaction|
        # Handle each transaction (e.g., save it to your database)
        # Example:
        t = Transaction.create(
          user_id: user.id,
          name: transaction.name,
          transaction_id: transaction.transaction_id,
          transaction_type: transaction.transaction_type,
          
          amount: transaction.amount,
          account_id: transaction.account_id,

          primary: transaction.personal_finance_category.primary,
          detailed: transaction.personal_finance_category.detailed,

          merchant_name: transaction.merchant_name,
          personal_finance_category_icon_url: transaction.personal_finance_category_icon_url,
          authorized_datetime: transaction.amount,
        )

        t.save!
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
