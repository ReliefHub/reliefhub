module Admin
  class ProjectsController < ApplicationController

    before_filter :find_organization

    def index
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(params[:project])
      if @project.save
        redirect_to admin_organization_projects_url
        flash[:message] = "Successfully created a new project called #{@project.name}"
      else
        render :action => :new
      end
    end

    def edit
      @project = Project.find params[:id]
    end

    def update
      @project = Project.find params[:id]
      respond_to do |format|
        if @project.update_attributes(params[:project])
          format.html { redirect_to admin_organization_projects_url }
          flash[:message] = "Successfully saved changes"
        else
          format.html { render :action => "edit" }
        end
      end
    end

    private

    def find_organization
      @organization = Organization.find params[:organization_id]
    end

  end
end
