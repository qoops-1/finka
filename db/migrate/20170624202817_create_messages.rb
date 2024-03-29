class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :conversation, foreign_key: true, index: true

      t.timestamps
    end
  end
end
