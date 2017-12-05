class AddUserRefToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_reference :expenses, :user, foreign_key: true
  end
end
