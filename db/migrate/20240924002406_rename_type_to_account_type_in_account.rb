class RenameTypeToAccountTypeInAccount < ActiveRecord::Migration[7.1]
  def change
    rename_column :accounts, :type, :account_type
  end
end
