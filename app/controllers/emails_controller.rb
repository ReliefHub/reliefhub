class EmailsController < ApplicationController
  def create
    if params[:email][:body].blank?
      flash[:failure] = 'Email was not sent. Please enter some text.'
    else
      from = if signed_in?
               current_user.email
             else
               params[:email][:from]
             end
      if from.blank?
        flash[:failure] = 'Email was not sent. Please enter your email address.'
      else
        Mailer.contact(from, params[:email][:body]).deliver
        flash[:success] = 'Thanks for contacting us.'
      end
    end
    redirect_to page_path('about_us')
  end
end
