class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.boolean :credit_account, default: false
      t.float :balance
      t.references :user, foreign_key: {on_delete: :cascade}


      t.timestamps
    end
  end
end
