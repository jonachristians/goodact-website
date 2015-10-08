class SearchesController < ApplicationController
  before_action :require_user, except: [:index]
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def index
    @searches = Search.all
  end

  def show
  end

  def new
    @search = Search.new
  end

  def edit
    if owner? @search
      render 'edit'
    else
      render 'show'
    end
  end

  def create
    @search = Search.new(offer_params)
    @search.image = "geo/#{rand(1..35)}.jpg" # TODO: use diffrent images
    @search.user_id = current_user.id if current_user
    # FIXME: or: @search = current_user.searches.new(offer_params)?
    if @search.save
      redirect_to @search, success: 'Successfully created search.'
    else
      render 'new'
    end
  end


  def update
    if owner? @search
      if @search.update(offer_params)
        redirect_to @search, success: 'Successfully updated your search.'
      else
        render 'edit'
      end
    else
      render 'show'
    end
  end

  def destroy
    user = @search.user
    if owner? @search
      @search.destroy
      redirect_to user, success: 'Destroyed your search'
    else
      render 'show'
    end
  end

  private

  def offer_params
    params.require(:search).permit(:description)
  end

  def set_search
    @search = Search.find(params[:id])
  end

end
