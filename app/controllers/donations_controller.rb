class DonationsController < ApplicationController
  
  def create
    @donation = Donation.create(params[:donation])
    redirect_to projects_url
  end
  
end
