class Income < ApplicationRecord

	# create_table "incomes", force: :cascade do |t|
 #    t.string "name"
 #    t.decimal "amount"
 #    t.string "category"
 #    t.boolean "regular"
 #    t.datetime "created_at", null: false
 #    t.datetime "updated_at", null: false
 #    t.date "date"
 #  end
 
	belongs_to :user
end
