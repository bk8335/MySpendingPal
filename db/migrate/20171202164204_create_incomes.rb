class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :name
      t.decimal :amount
      t.string :category
      t.boolean :regular

      t.timestamps
    end
  end
end
