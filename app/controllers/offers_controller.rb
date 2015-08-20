class OffersController < ApplicationController

  def index
    @offers = User.find(params[:user_id]).offers
    @user = User.find(params[:user_id])
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def show_all
    @offers = Offer.all
  end
  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(signup_params)
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render 'new'
    end
  end

  private
  def signup_params
    params.require(:offer).permit(:description)
  end
end
