require 'spec_helper'

describe DonationsController do

  describe "routes" do
    it { should route(:post, "/donations").to(:action => 'create') }
  end

  it 'should create a new donation' do
    Project.stubs(:create)
    post :create
    pending('this is just a placeholder until we integrate with amazon payments')
  end
  
end
