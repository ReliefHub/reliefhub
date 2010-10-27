class PagesController < ApplicationController
  def show
    render :template => "pages/#{params[:id].to_s}"
  end
end