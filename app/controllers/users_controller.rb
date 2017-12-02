class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Thanks for signing up! You can now log in with your submitted details"
      flash[:success] = "You can now finish your application here"

      # want to then redirect to the fixed entries page
      redirect_to user_url(@user)
  	else
  		flash[:error] = @user.errors.full_messages
  		render 'new'
  	end
  end

private
  def user_params
  	params.require(:user).permit(
  		:first_name,
  		:last_name,
  		:email,
  		:password,
  		:password_confirmation
  	)
  end
end