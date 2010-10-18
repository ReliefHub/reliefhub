require 'spec_helper'

describe Admin::ProjectsController do
  
  describe "index" do
    let(:project_array) { [ Factory.stub(:project), Factory.stub(:project) ] }

    before do
      Project.stubs(:all => project_array)
      get :index
    end

    it { should assign_to(:projects).with(project_array) }
  end

  describe "new" do
    let(:project) { Factory.build(:project) }

    before do
      Project.stubs(:new => project)
      get :new
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
        project.stubs(:save=>true)
        post :create, :project=>@data
      end
      it { should redirect_to(admin_projects_path) }
      it { should set_the_flash.to("Successfully created a new project called my project") }
    end

    describe 'failing' do
      before do
        project.stubs(:save=>false)
        post :create, :project=>@data
      end
      it { should render_template(:new) }
    end
  end
end
