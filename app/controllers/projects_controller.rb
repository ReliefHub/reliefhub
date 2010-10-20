class ProjectsController < ApplicationController
  
  def index
    @projects = Project.by_raised_amount
  end
  
end
