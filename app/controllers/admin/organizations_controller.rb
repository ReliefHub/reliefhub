class Admin::OrganizationsController < ApplicationController
  layout 'admin'

  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
    @organization.organization_photos.build
  end

  def create
    organization = Organization.new(params[:organization])
    if organization.save
      flash[:notice] = "Successfully created a new organizations called #{html_escape(organization.name)}"
      redirect_to admin_organizations_url
    else
      render :action => :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:id])
    @organization.organization_photos.build
  end

  def update
    organization = Organization.find(params[:id])
    if organization.update_attributes(params[:organization])
      flash[:notice] = "Successfully changed #{html_escape(organization.name)}"
      redirect_to admin_organization_url
    else
      render :action => :edit
    end
  end
end
