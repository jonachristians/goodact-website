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
      redirect_to @user, notice: "Welcome"
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
      #TODO notice
    end
  end

  def update
    @user = User.find(params[:id])
    if is_owner?
      if @user.update(update_params)
        redirect_to @user, notice: "Your profile is saved"
      else
        render 'edit'
        #TODO notice
      end
    else
      render 'show'
      #TODO notice
    end
  end

  def destroy
  end




  private
  def signup_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

  def update_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def is_owner?
    @user.id == current_user.id if current_user
  end

end
