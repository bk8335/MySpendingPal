class ChangeFirstName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :users, :first_name, :name
  end
end
