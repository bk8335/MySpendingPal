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

  def daily_budget
    days_per_month = Time.days_in_month(Date.current.month)
    disposable_income = recurring_incomes - recurring_expenses - recurring_savings
    budget_per_day = disposable_income / days_per_month
  end

  def recurring_incomes
    @user = User.first
    money_in = 0
    
    @user.incomes.all.each do |income|
      money_in += income.amount
    end
    money_in
  end

  def recurring_expenses
    @user = User.first
    money_out = 0
    
    @user.expenses.all.each do |expense|
      money_out += expense.amount
    end
    money_out
  end

  def recurring_savings
    @user = User.first
    savings_goal = 0
    
    @user.savings.all.each do |saving|
      savings_goal += saving.amount
    end
    savings_goal
  end
end
