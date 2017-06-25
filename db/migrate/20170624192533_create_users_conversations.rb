class CreateUsersConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :users_conversations do |t|
      t.integer :user_id, index: true, foreign_key: true
      t.integer :conversation_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
