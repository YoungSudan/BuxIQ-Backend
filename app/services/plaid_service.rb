require 'plaid'

class PlaidService
    attr_accessor :client
    def initialize
        configuration = Plaid::Configuration.new
        configuration.server_index = Plaid::Configuration::Environment["sandbox"]
        configuration.api_key["PLAID-CLIENT-ID"] = "655c535bb1fa53001a266984"
        configuration.api_key["PLAID-SECRET"] = "e9442b96ec89117bbf699c61a47823"
        
        api_client = Plaid::ApiClient.new(
          configuration
        )

        @client = Plaid::PlaidApi.new(api_client=api_client)
    end
end
  