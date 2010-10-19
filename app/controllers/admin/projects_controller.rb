class Admin::ProjectsController < ApplicationController
  include ERB::Util

  before_filter :organization

  def index
  end

  def new
    @project = organization.projects.build
  end

  def create
    @project = Project.new(params[:project])
    @project = organization.projects.build(params[:project])
    if @project.save
      redirect_to admin_organization_projects_url
      flash[:message] = "Successfully created a new project called #{html_escape(@project.name)}"
    else
      render :action => :new
    end
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    @project = Project.find params[:id]
    if @project.update_attributes(params[:project])
      redirect_to admin_organization_projects_url
      flash[:message] = "Successfully saved changes"
    else
      render :action => "edit"
    end
  end

  private

  def organization
    @organization ||= Organization.find params[:organization_id]
  end

end
