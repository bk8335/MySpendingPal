class Saving < ApplicationRecord
	belongs_to :user
	before_save :titlelize_names
	validates :amount, presence: true, numericality: { greater_than: 0}
  validates :name, presence: true
end
