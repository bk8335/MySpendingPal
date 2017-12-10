class ExpensesController < ApplicationController
  def new
  	@expense = Expense.new
  end

  def create
		@expense = current_user.expenses.build(expense_params)
  	if @expense.save
  		flash[:success] = "You just added an expense!"
  		redirect_to root_url
  	else
  		flash[:danger] = "You suck at adding an expense"
  	end
  end

  def show
  end

  def edit
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    flash[:success] = "You deleted the expense entry"
    redirect_to root_url
  end

  private
  def expense_params
  	params.require(:expense).permit(
  		:name,
  		:amount,
  		:category,
  		:date,
  		:regular,
  	)
  end
end
