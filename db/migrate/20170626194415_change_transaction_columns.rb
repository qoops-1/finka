class ChangeTransactionColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :body, :comment
    add_column :transactions, :type, :integer
    add_column :transactions, :ammount, :decimal, precision: 9, scale: 2
    add_column :transactions, :receiver_id, :integer
    add_column :transactions, :verified, :boolean
  end
end
