class SavingsController < ApplicationController
  def new
  	@saving = Saving.new
  end

   def create
		@saving = current_user.savings.build(saving_params)
  	if @saving.save
  		flash[:success] = "You just added a savings (goal)!"
  		redirect_to root_url
  	else
  		flash[:danger] = "You suck at adding savings"
  	end
  end

  def show
  end

  def edit
  end

  def destroy
    @saving = Saving.find(params[:id])
    @saving.destroy
    flash[:success] = "You deleted the saving entry"
    redirect_to root_url
  end

  private
  def saving_params
    params.require(:saving).permit(
      :name,
      :amount,
      :regular,
    )
  end
end
