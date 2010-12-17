require 'spec_helper'

describe Admin::ProjectsController do

  include Devise::TestHelpers

  let(:organization) { Factory.stub :organization }
  before do
    Organization.stubs(:find=>organization)
  end

  describe "routes" do
    it { should route(:get, "/admin/organizations/1/projects/17").to(:action => 'show', :organization_id=>1, :id=>17) }
    it { should route(:get, "/admin/projects").to(:action => 'index') }
  end

  describe 'admin role' do
    before do
      @user = Factory :user, :roles => [ 'admin' ]
      sign_in @user 
    end

    let(:project) { Factory.stub :project }

    describe 'admin projects' do 
      describe 'index' do
        let(:projects) { [stub] }
        before do
          Project.stubs(:all).returns(projects)
          get :index 
        end 
        it "should have called project.all" do
          Project.should have_received(:all)
        end
        it { should assign_to(:projects).with(projects)} 
        it { should respond_with(:success) }
      end
    end
    
    describe "index" do
      before do
        organization.stubs(:projects=>stub(:build=>Factory.stub(:project)))
        get :new, :organization_id => organization.id
      end

      it { should assign_to(:organization).with(organization) }
      it { should respond_with(:success) }
    end
    
    describe 'show' do
      let(:project)         { Factory.stub(:project)     }
      let(:projects_in_org) { stub(:find => project) }
      before do
        organization.stubs(:projects=>projects_in_org)
        Project.stubs(:find => project) # called by CanCan::ControllerResource.find_resource
        get :show, :organization_id => organization.id, :id=>project.id
      end

      it 'should be limited to projects in the organization' do
        projects_in_org.should have_received(:find).with(project.id)
      end
      it { should assign_to(:organization).with(organization) }
      it { should respond_with(:success) }
    end

    describe "new" do
      let(:project) { Factory.build(:project) }

      before do
        Project.stubs(:new => project)
        get :new, :organization_id => organization
      end

      it { should assign_to(:project).with(project) }
      it { should respond_with(:success) }
    end

    describe 'create' do
      let(:project)      { Factory.stub(:project)     }
      before do
        Project.stubs(:new=>project)
        project.stubs(:name=>'my project')
      end

      describe 'succeeds' do
        before do
          project.stubs(:save=>true)
          post :create, :project=>stub, :organization_id=>organization
        end
        it { should redirect_to(admin_organization_path(organization)) }
        it { should set_the_flash.to("Successfully created a new project called my project") }
      end

      describe 'failing' do
        before do
          project.stubs(:save=>false)
          post :create, :project=>stub, :organization_id=>organization
        end
        it { should render_template(:new) }
        it { should respond_with(:success) }
      end
    end
  end

  %w[field_operator organization_manager].each do |role|
    describe "#{role} role" do
      before do
        @user = Factory :user, :roles => [ role ]
        sign_in @user 
      end

      describe 'index' do
        before do
          get :index
        end
        it { should redirect_to(page_path('access_denied')) }
      end
      describe 'show' do
        let(:project)         { Factory.stub(:project)     }
        before do
          Project.stubs(:find => project)
          get :show, :organization_id => organization.id, :id=>project.id
        end
        it { should redirect_to(page_path('access_denied')) }
      end
      describe 'new' do
        before do
          get :new, :organization_id => organization.id
        end
        it { should redirect_to(page_path('access_denied')) }
      end
      describe 'create' do
        before do
          post :create, :organization_id=>organization
        end
        it { should redirect_to(page_path('access_denied')) }
      end
      describe 'update' do
        let(:project)         { Factory.stub(:project)     }
        before do
          Project.stubs(:find => project)
          post :update, :id=>project.id, :organization_id=>organization.id
        end
        it { should redirect_to(page_path('access_denied')) }
      end
    end
  end

  describe 'anonymous user' do
    describe 'index' do
      before do
        get :index
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
    describe 'index' do
      before do
        get :index
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
    describe 'show' do
      let(:project)         { Factory.stub(:project)     }
      before do
        Project.stubs(:find => project)
        get :show, :organization_id => organization.id, :id=>project.id
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
    describe 'new' do
      before do
        get :new, :organization_id => organization.id
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
    describe 'create' do
      before do
        post :create, :organization_id=>organization
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
    describe 'update' do
      let(:project)         { Factory.stub(:project)     }
      before do
        Project.stubs(:find => project)
        post :update, :id=>project.id, :organization_id=>organization.id
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
  end
end
