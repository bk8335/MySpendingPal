class ExpensesController < ApplicationController
  def new
  	@expense = Expense.new
    @expense.date = Date.today
    @user = current_user
  end

  def create
    @expense = current_user.expenses.build(expense_params)
  	if @expense.save
  		flash[:success] = "You just added an expense!"
      redirect_to user_monthly_entries_path(current_user)
  	else
  		flash[:danger] = "You suck at adding an expense"
  	end
  end

  def show
  end

  def edit
    @expense = Expense.find(params[:id])
    @user = current_user
  end

  def update
     @expense = Expense.find(params[:id])
     @user = current_user
    if @expense.update_attributes(expense_params)
      flash[:success] = "Expense entry updated"
      redirect_to user_monthly_entries_path(current_user)
    else
      flash[:error] = @expense.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:success] = "You deleted the expense entry"
    redirect_back(fallback_location: current_user)
  end

  private
  def expense_params
  	params.require(:expense).permit(
  		:name,
  		:amount,
  		:category,
  		:date,
  		:regular
  	)
  end
end
