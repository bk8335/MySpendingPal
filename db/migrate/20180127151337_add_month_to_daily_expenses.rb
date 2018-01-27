class AddMonthToDailyExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :daily_expenses, :month, :integer
  end
end
