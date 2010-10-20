require 'spec_helper'

describe ProjectsController do

  it 'should return all projects by perecent raised' do
    Project.stubs(:by_raised_amount).returns(:all_projects)
    get :index
    response.should be_success
    assigns[:projects].should == :all_projects
  end
  
end