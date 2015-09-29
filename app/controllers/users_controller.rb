class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    @user.image = "maya/#{rand(1..47)}.jpg"
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome on board"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if is_owner?
      render 'edit'
    else
      render 'show'
    end
  end

  def update
    @user = User.find(params[:id])
    if is_owner?
      if @user.update(update_params)
        flash[:success] = "Successfully updated your profile"
        redirect_to @user
      else
        render 'edit'
      end
    else
      render 'show'
    end
  end

  def destroy
  end




  private
  def signup_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def update_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def is_owner?
    @user.id == current_user.id if current_user
  end

end
