require 'spec_helper'

describe HomesController, "routes" do
  it { should route(:get, "/").to(:action => 'show') }
end

describe HomesController, "GET to show" do
  let(:featured_projects)  { [Factory.stub(:project)] }
  before do
    Project.stubs(:limit=>featured_projects)
    get :show 
  end

  it { should render_template(:show) }
  it { should respond_with(:success) }
  it { should assign_to(:featured_projects).with(featured_projects) }
end
