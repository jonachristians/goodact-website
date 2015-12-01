class SessionsController < ApplicationController
before_action :already_logged_in, only: :new
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to requested_url || user, success: 'You successfully logged in.'
    else
      flash.now[:danger] = "You're e-mail and password don't match up."
      render 'new'
    end
  end

  def destroy
    log_out
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
