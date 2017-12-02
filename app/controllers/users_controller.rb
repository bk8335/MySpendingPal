class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      flash[:success] = "Thanks for signing up! You can now log in with your submitted details"
      flash[:success] = "You can now finish your application here"
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

private
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email)
  end
end