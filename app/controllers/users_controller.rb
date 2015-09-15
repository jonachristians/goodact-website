class UsersController < ApplicationController
  before_action :require_user, only: [:index, :show]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(signup_params)
    @user.image = "maya/#{rand(1..15)}.jpg"
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/' #does this work???
    else
      render 'new'
    end
  end



  def show
    @user = User.find(params[:id])
  end

  private
  def signup_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
