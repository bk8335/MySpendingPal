class AddNameToSavings < ActiveRecord::Migration[5.1]
  def change
    add_column :savings, :name, :string
  end
end
