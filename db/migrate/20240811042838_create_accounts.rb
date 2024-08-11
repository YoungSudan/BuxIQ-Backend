class CreateAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :accounts do |t|
      t.string :account_id, null:false
      t.string :name
      t.string :official_name

      t.decimal :available, precision: 10, scale: 2
      t.decimal :current, precision: 10, scale: 2
      t.decimal :limit, precision: 10, scale: 2, default: nil, null: true
      t.string :currency_code

      t.string :mask
      t.string :subtype
      t.string :type

      t.timestamps
    end
  end
end
