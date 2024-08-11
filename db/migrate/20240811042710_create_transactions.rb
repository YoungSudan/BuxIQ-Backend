class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :transaction_id
      t.string :transaction_code
      t.string :transaction_type
      t.string :account_id

      t.decimal :amount, precision: 10, scale: 2
      t.string :currency_code
      
      t.string :name
      t.string :merchant_name
      t.string :website
      t.string :logo_url
      
      t.string :payment_channel
      t.boolean :pending

      t.string :category_id
      t.string :primary
      t.string :detailed
      t.string :personal_finance_category_icon_url


      t.date :authorized_date
      t.datetime :authorized_datetime

      t.timestamps
    end
  end
end
