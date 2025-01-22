class AddAccountReferenceToTransactions < ActiveRecord::Migration[7.1]
  def change
     add_reference :transactions, :account
  end
end
