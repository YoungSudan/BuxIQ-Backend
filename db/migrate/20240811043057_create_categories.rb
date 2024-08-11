class CreateCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false 
      t.string :sub_category, null: true 
      t.string :plaid_category_id, null: true 
      t.text :description, null: false
      t.text :plaid_hierarchy, null: true, array: true, default: []
      t.timestamps
    end
  end
end
