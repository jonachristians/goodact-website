class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
    if herself?
      render 'edit'
    else
      render 'show'
    end
  end

  def create
    @user = User.new(signup_params)
    @user.image = "maya/#{rand(1..47)}.jpg"
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, success: 'Welcome on board'
    else
      render 'new'
    end
  end

  def update
    if herself?
      if @user.update(update_params)
        redirect_to @user, success: 'Successfully updated your profile'
      else
        render 'edit'
      end
    else
      render 'show'
    end
  end

  def destroy
    if herself?
      @user.destroy
      session[:user_id] = nil
      redirect_to root_path, success: 'We will miss you.'
    else
      render 'show'
    end
  end

  private

  def signup_params
    params.require(:user).permit(
      :username, :email, :zipcode, :password,
      :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
