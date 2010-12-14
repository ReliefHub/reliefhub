require 'spec_helper'

describe ProjectsController, "routes" do
  it { should route(:get, "/projects").  to(:action => 'index') }
  it { should route(:get, "/projects/1").to(:action => 'show', :id => 1) }
end

describe ProjectsController, "GET to index" do
  let(:projects) { [] }

  before do
    Project.stubs(:paginate).returns(projects)
    get :index
  end

  it "sorts by updated date" do
    Project.should have_received(:paginate)
  end

  it { should assign_to(:projects).with(projects) }
  it { should render_template(:index) }
  it { should respond_with(:success) }
end

describe ProjectsController, "GET to show" do
  let(:project) { Factory(:project) }
  let(:comment) { Comment.new }

  before do
    get :show, :id => project.to_param
    Comment.stubs(:new).returns(comment)
  end

  it { should assign_to(:project).with(project) }
  it { should assign_to(:comment).with(comment) }
  it { should render_template(:show) }
  it { should respond_with(:success) }
end
