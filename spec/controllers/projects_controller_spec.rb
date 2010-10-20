require 'spec_helper'

describe ProjectsController do

  describe "routes" do
    it { should route(:get, "/projects/17").to(:action => 'show', :id=>17) }
  end

  it 'should return all projects with no sort' do
    Project.stubs(:all).returns(:all_projects)
    get :index
    response.should be_success
    assigns[:projects].should == :all_projects
  end
  
end