class Admin::ProjectsController < ApplicationController
  include ERB::Util

  before_filter :organization

  def index
  end

  def show
    @project = organization.projects.find params[:id]
  end

  def new
    @project = organization.projects.build
    @project.project_photos.build
  end

  def create
    @project = Project.new(params[:project])
    @project = organization.projects.build(params[:project])
    if @project.save
      flash[:message] = "Successfully created a new project called #{html_escape(@project.name)}"
      redirect_to admin_organization_project_url(organization, @project)
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
      flash[:message] = "Successfully saved changes"
      redirect_to admin_organization_project_url(organization, @project)
    else
      render :action => "edit"
    end
  end

  private

  def organization
    @organization ||= Organization.find params[:organization_id]
  end

end
