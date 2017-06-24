class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :string
      t.string :phone
      t.string :string
      t.float :balance
      t.time :creation_date

      t.timestamps
    end
  end
end
