class ProjectsController < ApplicationController
  def index
    @projects = Project.by_updated_date
  end

  def show
    @project = Project.find(params[:id])
  end
  
  def my_projects
    @projects = current_user.projects_i_have_contributed_to
  end
  
end
