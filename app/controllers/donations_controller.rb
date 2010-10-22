class DonationsController < ApplicationController

  def create
    donation = Donation.new(params[:donation].merge(:user=>current_user))
    payment_token = donation.authorize(confirm_donation_url(donation)) if donation.save
    if payment_token
      session[:payment] = payment_token
      redirect_to payment_token.url
    else
      render :action => :new
    end
  end

  def confirm
    donation = Donation.find(params[:id])
    payment_token = session[:payment]
    result = donation.confirm(request.url, payment_token) if donation && payment_token
    if result
      redirect_to root_url
    else
      render :action => :new
    end
  end

end
