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
    @currency = @user.currency_symbol(current_user)
  end

  def monthly_entries
    @user = current_user
    @incomes = @user.incomes.all.order('date DESC')
    @expenses = @user.expenses.all.order('date DESC')
    @savings = @user.savings.all
    @daily_expenses = @user.daily_expenses.all.order('date DESC')
    @currency = @user.currency_symbol(current_user)
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		log_in @user
      flash[:success] = "Thanks for signing up! Enter your monthly entries here to calculate your daily budget"
      redirect_to user_monthly_entries_path(@user)
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