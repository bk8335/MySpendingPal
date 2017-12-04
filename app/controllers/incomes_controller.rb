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
  		flash[:danger] = "You suck"
  	end
  end

  def show
  end

  def edit
  end

  def destroy
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
