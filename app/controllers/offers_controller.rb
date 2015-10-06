class OffersController < ApplicationController
  before_action :require_user, except: [:index]
  # before_action :require_editor, only: [:edit] NOTE: role auth
  # before_action :require_admin, only: [:destroy] NOTE: role auth

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
    @offer.image = "geo/#{rand(1..35)}.jpg"
    @offer.user_id = current_user.id if current_user
    # or: @offer = current_user.offers.new(offer_params)
    if @offer.save
      redirect_to @offer, success: 'Successfully created offer.'
    else
      render 'new'
    end
  end

  def edit
    @offer = Offer.find(params[:id])
    if owner?
      render 'edit'
    else
      render 'show', danger: 'You are not the owner.'
    end
  end

  def update
    @offer = Offer.find(params[:id])
    if owner?
      if @offer.update(offer_params)
        redirect_to @offer, success: 'Successfully updated your offer.'
      else
        render 'edit'
      end
    else
      render 'show'
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    user = @offer.user
    if owner?
      @offer.destroy
      redirect_to user, success: 'Destroyed your offer'
    else
      render 'show'
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:description)
  end

  def owner?
    @offer.user_id == current_user.id if current_user
  end

end
