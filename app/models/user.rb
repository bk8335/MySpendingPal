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

  def daily_budget(user)
    days_per_month = Time.days_in_month(Date.current.month)
    disposable_income = recurring_incomes(user) - recurring_expenses(user) - recurring_savings(user)
    budget_per_day = (disposable_income / days_per_month).round(2)
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
end
