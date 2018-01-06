class SavingsController < ApplicationController
  def new
  	@saving = Saving.new
    @user = current_user
  end

   def create
		@saving = current_user.savings.build(saving_params)
  	if @saving.save
  		flash[:success] = "You just added a savings (goal)!"
      redirect_to user_monthly_entries_path(current_user)
  	else
  		flash[:danger] = "You suck at adding savings"
  	end
  end

  def show
  end

  def edit
    @saving = Saving.find(params[:id])
    @user = current_user
  end

  def update
    @saving = Saving.find(params[:id])
    @user = current_user
    if @saving.update_attributes(saving_params)
      flash[:success] = "Saving entry updated"
      redirect_to user_monthly_entries_path(current_user)
    else
      flash[:error] = @saving.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @saving = Saving.find(params[:id])
    @saving.destroy
    flash[:success] = "You deleted the saving entry"
    redirect_back(fallback_location: current_user)
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
