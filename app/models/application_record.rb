class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_currency(amount, options = {})
   return nil if amount.nil?

   precision = options.fetch(:precision, 2)

   formatted_amount = BigDecimal(amount.to_s)
   formatted_amount = format("%.#{precision}f", formatted_amount)
   formatted_amount = ActionController::Base.helpers.number_with_delimiter(formatted_amount)
   formatted_amount = "#{formatted_amount}"
   formatted_amount
  end

  def titlelize_names
    self.name = self.name.titleize
  end
end
