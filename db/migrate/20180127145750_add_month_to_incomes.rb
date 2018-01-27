class AddMonthToIncomes < ActiveRecord::Migration[5.1]
  def change
    add_column :incomes, :month, :integer
  end
end
