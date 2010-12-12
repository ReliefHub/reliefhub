class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate(:page => params[:page], :order => 'updated_at DESC')
  end

  def show
    @project  = Project.find(params[:id])
    @comment = Comment.new
  end

  def my_projects
    @projects = current_user.unique_projects
  end
end
