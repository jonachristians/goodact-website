class SessionsController < ApplicationController
before_action :already_logged_in, only: :new
  def new
    flash.keep(:requested_url)
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to flash[:requested_url] || @user, success: 'You successfully logged in.'
    else
      flash.now[:danger] = "You're e-mail and password don't match up."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:requested_url] = nil
    redirect_to '/', info: 'You are now logged out.'
  end

  private

  def already_logged_in
    if current_user
      redirect_to "/", info: "You are already logged in."
    end
  end
end
