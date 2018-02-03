class Income < ApplicationRecord
	belongs_to :user
	before_save :titlelize_names
	validates :amount, presence: true, numericality: { greater_than: 0}
  validates :name, presence: true
  validates :date, presence: true
  before_save :set_month

  private 

  def set_month
  	self.month = self.date.month
  end

end
