class Expense < ApplicationRecord
	belongs_to :user
	before_save :titlelize_names
	validates :amount, presence: true, numericality: { greater_than: 0}
  validates :name, presence: true
  validates :category, presence: true
  validates :date, presence: true
end
