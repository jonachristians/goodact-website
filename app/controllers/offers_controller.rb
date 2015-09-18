class OffersController < ApplicationController
before_action :require_user, except: [:index]
# before_action :require_editor, only: [:edit] <-- was used with the role model
# before_action :require_admin, only: [:destroy]
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
      flash[:success] = "Successfully created offer."
      redirect_to @offer
    else
      render 'new'
    end
  end

  def edit
    @offer = Offer.find(params[:id])
    if is_owner?
      render 'edit'
    else
      flash[:error] = "You are not the owner."
      render 'show'
    end
  end

  def update
    @offer = Offer.find(params[:id])
    if is_owner?
      if @offer.update(offer_params)
        flash[:success] = "Successfully updated your offer."
        redirect_to @offer
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
    if is_owner?
      @offer.destroy
      flash[:success] = "Destroyed your offer"
      redirect_to user
    else
      render 'show'
    end
  end

  private
  def offer_params
    params.require(:offer).permit(:description)
  end

  def is_owner?
    @offer.user_id == current_user.id if current_user
  end

end
