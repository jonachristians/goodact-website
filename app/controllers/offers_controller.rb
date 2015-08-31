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
    @offer.image = "geo/#{rand(1..15)}.jpg"
    @offer.user_id = 1
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

  def random_picture
    random_number = rand(1..15)
    @picture = File.read("geo/#{random_number}.jpg")
  end

end
