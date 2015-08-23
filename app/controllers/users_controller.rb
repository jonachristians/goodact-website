class UsersController < ApplicationController
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
      redirect_to user_path(@user) #does this work???
    else
      render 'new'
    end
  end



  def show
    @user = User.find(params[:id])
  end

  private
  def signup_params
    params.require(:user).permit(:name)
  end

end
