class Saving < ApplicationRecord
	belongs_to :user
	before_save :titlelize_names
	after_create :set_month
	validates :amount, presence: true, numericality: { greater_than: 0}
  validates :name, presence: true

  private 

  def set_month
  	self.month = self.date.month
  end
end
