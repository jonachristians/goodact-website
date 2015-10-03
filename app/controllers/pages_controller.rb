class PagesController < ApplicationController
  def welcome
    @offers = Offer.all
  end
end
