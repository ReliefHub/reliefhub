class Admin::UsersController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  def index
    @users = User.all
  end
end
