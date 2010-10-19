require 'spec_helper'

describe HomesController, "routes" do
  it { should route(:get, "/").to(:action => 'show') }
end

describe HomesController, "GET to show" do
  before { get :show }

  it { should render_template(:show) }
  it { should respond_with(:success) }
end
