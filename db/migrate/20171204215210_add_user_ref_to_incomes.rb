class AddUserRefToIncomes < ActiveRecord::Migration[5.1]
  def change
    add_reference :incomes, :user, foreign_key: true
  end
end
