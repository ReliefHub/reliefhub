class Admin::UsersController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  def index
    @users = User.ascending.paginate :page => params[:page], :per_page => 10
  end
end
