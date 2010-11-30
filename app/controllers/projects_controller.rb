class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate :page => params[:page], :order => 'updated_at DESC'
  end

  def show
    @project = Project.find(params[:id])
  end
  
  def my_projects
    @projects = current_user.projects_i_have_contributed_to
  end
  
end
