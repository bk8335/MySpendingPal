class User < ApplicationRecord
	attr_accessor :remember_token
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 255 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	has_many :incomes
	has_many :expenses
	has_many :savings
  has_many :daily_expenses

	# Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
  	return false if remember_digest.nil?
  	BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def disposable_income(user)
    recurring_incomes(user) - recurring_expenses(user) - recurring_savings(user)
  end

  def recurring_incomes(user)
    user.incomes.sum(:amount)
  end

  def recurring_expenses(user)
    user.expenses.sum(:amount)
  end

  def recurring_savings(user)
    user.savings.sum(:amount)
  end

  def daily_spending_total(user)
    user.daily_expenses.sum(:amount)
  end

  def daily_spending_total_yesterday(user)
    total_yesterday = 0
    user.daily_expenses.each do |expense|
      if expense.date < Date.today
        total_yesterday += expense.amount
      end
    end
    total_yesterday
  end

  def days_in_current_month
    Time.days_in_month(Time.now.month)
  end

  def time_progress_percentage
    (( Time.now.day / days_in_current_month.to_d ) * 100).round(1)
  end

  def spend_progress_percentage(user)
    (( daily_spending_total(user) / disposable_income(user).to_d ) * 100).round(1)
  end

  def spend_time_ratio(user)
    spend_progress_percentage(user) / time_progress_percentage
  end

  def spend_ratio_feedback(user)
    if spend_time_ratio(user) < 1
      "Great job - you're ahead of target!"
    elsif spend_time_ratio < 1.1 
      "Keep going, you're not too far off target"
    else
      "Uh oh!"
    end
  end

  def currency_symbol(user)
    if user.primary_currency == "GBP"
      "£"
    elsif user.primary_currency == "EUR"
      "€"
    elsif user.primary_currency == "USD"
      "$"
    else
      "£"
    end
  end

  def spend_today(user)
    user.daily_expenses.where(date: DateTime.now.to_date).sum(:amount)
  end

  def spend_on_date(user, date)
    user.daily_expenses.where(date: date).sum(:amount)
  end

  def remaining_today(user)
    dynamic_daily_budget(user) - spend_today(user)
  end

  def daily_spend_detail(user, date)
    user.daily_expenses.where(date: date)
  end

  def each_day_of_month
    date = DateTime.now.end_of_month.to_date
    loop do
      date
      date -= 1.day
      break if date.month == (DateTime.now.month - 1)
    end
  end

  def daily_budget(user)
    days_per_month = Time.days_in_month(Date.current.month)
    budget_per_day = (disposable_income(user) / days_per_month)
  end

  def dynamic_daily_budget(user)
    days_per_month = Time.days_in_month(Date.current.month)
    days_complete = Date.current.day - 1
    days_left = days_per_month - days_complete

    spend_left = disposable_income(user) - daily_spending_total_yesterday(user)

    dynamic_daily_budget = (spend_left / days_left)
  end

  def complete_day_forecast(user)
    budget_remaining = disposable_income(user) - daily_spending_total(user)
    days_per_month = Time.days_in_month(Date.current.month)
    days_complete = Date.current.day
    days_left = days_per_month - days_complete
    forecast = budget_remaining - (spend_today(user) * days_left)
  end

  def forecast_result(user)
    if complete_day_forecast(user) >= 0
      "Great job, you're ahead of target!"
    else
      "Be careful, at this rate, you're going to be out of money before the end of the month"
    end
  end
end
