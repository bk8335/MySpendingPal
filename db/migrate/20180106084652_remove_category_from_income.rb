class RemoveCategoryFromIncome < ActiveRecord::Migration[5.1]
  def change
    remove_column :incomes, :category, :string
  end
end
