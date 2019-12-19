class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.timestamp :date
      t.float :price
      t.string :location
      t.string :category
      t.boolean :necessity
      t.references :user, foreign_key: true
      t.references :account, foreign_key: true
      t.references :budget, foreign_key: true

      t.timestamps
    end
  end
end
