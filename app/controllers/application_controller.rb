class ApplicationController < ActionController::Base
  # before_action :see_request
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  helper_method :current_user, :owner?, :herself?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
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
