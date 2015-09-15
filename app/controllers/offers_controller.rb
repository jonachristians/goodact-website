class OffersController < ApplicationController
before_action :require_user, except: [:index]
# before_action :require_editor, only: [:edit] <-- was used with the role model
before_action :require_admin, only: [:destroy]
  def index
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.image = "geo/#{rand(1..15)}.jpg"
    @offer.user_id = current_user.id if current_user
    # or: @offer = current_user.offers.new(offer_params)
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render 'new'
    end
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.update(offer_params)
      redirect_to @offer
    else
      render 'edit'
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy
    redirect_to root_url
  end

  private
  def offer_params
    params.require(:offer).permit(:description)
  end



end
