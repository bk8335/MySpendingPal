class AddColumnToIncome < ActiveRecord::Migration[5.1]
  def change
    add_column :incomes, :date, :date
  end
end
