require 'spec_helper'

describe Admin::ProjectsController do
  
  describe "index" do
    before do
      @org = Factory :organization
      get :new, :organization_id => @org.to_param
    end

    it { should assign_to(:organization).with(@org) }
  end

  describe "new" do
    let(:project) { Factory.build(:project) }

    before do
      org = Factory :organization
      Project.stubs(:new => project)
      get :new, :organization_id => org.to_param
    end

    it { should assign_to(:project).with(project) }
  end

  describe 'create' do
    let(:project) { Factory.build(:project) }
    before do
      @data = stub
      Project.stubs(:new=>project)
      project.stubs(:name=>'my project')
    end

    describe 'succeeds' do
      before do
        org = Factory :organization
        project.stubs(:save=>true)
        post :create, :project=>@data, :organization_id=>org.to_param
      end
      it { should redirect_to(admin_organization_projects_path) }
      it { should set_the_flash.to("Successfully created a new project called my project") }
    end

    describe 'failing' do
      before do
        org = Factory :organization
        project.stubs(:save=>false)
        post :create, :project=>@data, :organization_id=>org.to_param
      end
      it { should render_template(:new) }
    end
  end
end
