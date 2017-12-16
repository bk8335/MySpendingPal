class IncomesController < ApplicationController
  def new
  	@income = Income.new
  end

  def create
  	@income = current_user.incomes.build(income_params)
  	if @income.save
  		flash[:success] = "You just added an income!"
  		redirect_to root_url
  	else
  		flash[:danger] = "You suck at adding an income"
  	end
  end

  def show
  end

  def edit
    @income = Income.find(params[:id])
  end

  def update
     @income = Income.find(params[:id])
    if @income.update_attributes(income_params)
      flash[:success] = "Income entry updated"
      redirect_to root_url
    else
      flash[:error] = @income.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @income = Income.find(params[:id])
    @income.destroy
    flash[:success] = "You deleted the income entry"
    redirect_to root_url
  end

  private
  def income_params
  	params.require(:income).permit(
  		:name,
  		:amount,
  		:category,
  		:date,
  		:regular,
  	)
  end
end
