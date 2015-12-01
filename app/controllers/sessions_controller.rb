class SessionsController < ApplicationController
before_action :already_logged_in, only: :new
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to requested_url || @user, success: 'You successfully logged in.'
    else
      flash.now[:danger] = "You're e-mail and password don't match up."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, info: 'You are now logged out.'
  end

  private

  def already_logged_in
    if current_user
      redirect_to "/", info: "You are already logged in."
    end
  end

  def requested_url
    session.delete(:requested_url)
  end
end
