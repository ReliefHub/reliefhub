class ProjectsController < ApplicationController
  def index
    @projects = Project.by_updated_date
  end

  def show
    @project = Project.find(params[:id])
  end
end
