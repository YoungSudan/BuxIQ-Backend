class AddTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :plaid_token, :string
  end
end
