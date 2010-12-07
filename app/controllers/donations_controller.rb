class DonationsController < ApplicationController
  def confirm
    project  = Project.where(:id => params[:referenceId]).first
    donation = Donation.new(
      :user               => current_user,
      :project            => project,
      :transaction_amount => params[:transactionAmount],
      :transaction_id     => params[:transactionId],
      :status             => params[:status]
    )
    if donation.save
      redirect_to page_path('thank_you')
    else
      redirect_to page_path('donation_error')
    end
  end

  def abandon
    redirect_to page_path('donation_error')
  end
end
