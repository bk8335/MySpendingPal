class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @incomes = @user.incomes.all.order('date DESC')
    @expenses = @user.expenses.all.order('date DESC')
    @savings = @user.savings.all
    @daily_expenses = @user.daily_expenses.all.order('date DESC')
    @currency = @user.primary_currency
  end

  def monthly_entries
    @user = current_user
    @incomes = @user.incomes.all.order('amount DESC')
    @expenses = @user.expenses.all.order('amount DESC')
    @savings = @user.savings.all
    @daily_expenses = @user.daily_expenses.all.order('date DESC')
    @currency = @user.primary_currency
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info] = "Thanks for signing up! Please check your email to activate your account."
      redirect_to root_url
  	else
  		flash[:error] = @user.errors.full_messages
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages
      render 'edit'
    end
  end

  def analysis
    @month = Date.today.month
    @currency = current_user.primary_currency
    @grouped_monthly_expenses = current_user.expenses.group(:category).where(month: @month).sum(:amount)
    @grouped_daily_expenses = current_user.daily_expenses.group(:category).where(month: @month).sum(:amount)
  end

  def analysis_last_month
    @month = Date.today.month - 1
    @currency = current_user.primary_currency
    @grouped_monthly_expenses = current_user.expenses.group(:category).where(month: @month).sum(:amount)
    @grouped_daily_expenses = current_user.daily_expenses.group(:category).where(month: @month).sum(:amount)
  end

private
  def user_params
  	params.require(:user).permit(
  		:name,
  		:email,
  		:password,
  		:password_confirmation,
      :primary_currency
  	)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end