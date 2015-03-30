class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to home_path 
      flash[:success] = "You are now registered"
    else
      render "new"
    end
  end

  def edit
  end

  def update
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
 

end