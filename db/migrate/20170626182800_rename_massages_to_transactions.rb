class RenameMassagesToTransactions < ActiveRecord::Migration[5.0]
  def self.up
    rename_table :messages, :transactions
  end

  def self.down
    rename_table :transactions, :messages
  end
end
