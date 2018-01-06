class Income < ApplicationRecord
	belongs_to :user
	validates :amount, presence: true, numericality: { greater_than: 0}
  validates :name, presence: true
  validates :date, presence: true
end
