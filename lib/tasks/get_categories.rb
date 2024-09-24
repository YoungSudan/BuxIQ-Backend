require 'plaid'
require 'csv'

namespace :plaid do
    desc 'Create Plaid Categories'
    task get_categories: [:environment] do
        puts 'Creating Categories...\n'
        CSV.foreach(("public/transactions-personal-finance-category-taxonomy.csv"), headers: true, col_sep: ",") do |row|
            puts "[Creating Category #{row[0]}-#{row[1]}]"
            Category.create!(
                name: row[0],
                sub_category: row[1],
                description: row[2]
            )
        end
    end
  end