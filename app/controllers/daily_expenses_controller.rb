class DailyExpensesController < ApplicationController
  def new
  	@daily_expense = DailyExpense.new
    @daily_expense.date = Date.today
  end

  def create
		@daily_expense = current_user.daily_expenses.build(daily_expense_params)
  	if @daily_expense.save
  		flash[:success] = "You just added a daily expense!"
  		redirect_to current_user
  	else
  		flash[:danger] = "You suck at adding daily expenses"
  	end
  end

  def show
  end

  def edit
  	@daily_expense = DailyExpense.find(params[:id])
  end

  def update
  	@daily_expense = DailyExpense.find(params[:id])
  	if @daily_expense.update_attributes(daily_expense_params)
      flash[:success] = "Daily expense updated"
      redirect_to current_user
    else
      flash[:error] = @daily_expense.errors.full_messages
      render 'edit'
    end
  end

  def destroy
  	@daily_expense = DailyExpense.find(params[:id])
  	@daily_expense.destroy
  	flash[:success] = "You deleted the daily expense entry"
    redirect_back(fallback_location: current_user)
  end

  private

  def daily_expense_params
  	params.require(:daily_expense).permit(
  		:name,
  		:amount,
  		:category,
  		:date
  	)
  end
end
