class AddMonthToSavings < ActiveRecord::Migration[5.1]
  def change
    add_column :savings, :month, :integer
  end
end
