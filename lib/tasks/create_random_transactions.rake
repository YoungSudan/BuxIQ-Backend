require 'faker'

namespace :plaid do
  desc 'Create 100 random transactions'
  task create_random_transactions: [:environment] do
    100.times do
      # Generate random date and datetime
      random_date = Faker::Date.backward(days: rand(1..730)) # Up to 2 years in the past
      random_datetime = Faker::Time.between(from: 2.years.ago, to: Time.now, format: :default)

      t = Transaction.create!(
        transaction_id: Faker::Alphanumeric.alphanumeric(number: 10),
        transaction_code: Faker::Alphanumeric.alphanumeric(number: 10),
        transaction_type: Faker::Commerce.department,
        account_id: Faker::Alphanumeric.alphanumeric(number: 10),
        amount: Faker::Commerce.price(range: 1.0..1000.0, as_string: true),
        currency_code: Faker::Currency.code,
        name: Faker::Commerce.product_name,
        merchant_name: Faker::Company.name,
        website: Faker::Internet.url,
        logo_url: Faker::Avatar.image,
        payment_channel: nil,
        pending: Faker::Boolean.boolean,
        category_id: Faker::Alphanumeric.alphanumeric(number: 10),
        primary: Faker::Alphanumeric.alphanumeric(number: 10),
        detailed: Faker::Lorem.sentence,
        personal_finance_category_icon_url: Faker::Avatar.image,
        authorized_date: random_date,
        authorized_datetime: random_datetime,
        user_id: User.first.id
      )
      puts "Creating transactions: #{t.id}...\n"
    end
  end
end







