class CreateBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :budgets do |t|
      t.string :name
      t.float :limit
      t.string :category
      t.datetime :start
      t.datetime :end
      t.references :user, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
