class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.decimal :amout, precision: 10, scale: 2
      t.date :budget_start_date, null: true
      t.date :budget_end_date, null: true
      t.date :reset_date, null: true
      
      t.timestamps
    end
  end
end
