class RelateAccountsToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_reference :transactions, :user, null: false, foreign_key: true
    add_reference :accounts, :user, null: false, foreign_key: true
  end
end
