class UsersController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  def projects
    @projects = current_user.projects.paginate :page => params[:page], :per_page => 10
  end
end
