class ApplicationController < ActionController::Base
  # before_action :see_request

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  helper_method :current_user, :owner?, :herself?, :logged_in?

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies.signed[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def require_user
    unless logged_in?
      session[:requested_url] = request.fullpath
      redirect_to '/login', info: 'You must be logged in to visit that page.'
    end
  end

  def owner?(record)
    record.user_id == current_user.id if current_user
  end

  def herself?
    @user.id == current_user.id if current_user
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  # def require_editor NOTE: role auth
  #   redirect_to '/' unless current_user.editor?
  # end
  # def require_admin NOTE: role auth
  #  redirect_to '/' unless current_user.admin?
  # end

  # def see_request
  #   logger.info request.env
  # end

end
