class ProjectsController < ApplicationController
  
  def index
    @projects = Project.by_updated_date
  end
  
end
