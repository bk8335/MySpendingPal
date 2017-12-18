class CreateDailyExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_expenses do |t|
      t.string :name
      t.decimal :amount
      t.string :category
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
