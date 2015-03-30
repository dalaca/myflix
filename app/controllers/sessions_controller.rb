class SessionsController < ApplicationController

  def new
    redirect_to home_path if signed_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.password == (params[:password_digest])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'You have logged in'
    else
      flash[:error] = 'Invalid email or password'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have signed out"
    redirect_to root_path
  end

end