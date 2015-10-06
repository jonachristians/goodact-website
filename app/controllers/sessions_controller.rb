class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/', success: 'You successfully logged in.'
    else
      render 'new', error: "You're e-mail and password don't match up."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', info: 'You are now logged out.'
  end

end
