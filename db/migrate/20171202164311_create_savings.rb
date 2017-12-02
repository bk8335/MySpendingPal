class CreateSavings < ActiveRecord::Migration[5.1]
  def change
    create_table :savings do |t|
      t.decimal :amount
      t.boolean :regular

      t.timestamps
    end
  end
end
