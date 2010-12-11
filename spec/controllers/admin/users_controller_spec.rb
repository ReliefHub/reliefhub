require 'spec_helper'

describe Admin::UsersController do

  include Devise::TestHelpers

  before do
    @user = Factory :user, :roles => [ 'site_admin' ]
    sign_in @user 
  end

  describe "routes" do
    it { should route(:get, "/admin/users").to(:action => 'index') }
  end

  describe 'admin users' do 
    describe 'index' do
      let(:users) { [stub] }
      before do
        User.stubs(:all).returns(users)
        get :index 
      end 
      it "should have called User.all" do
        User.should have_received(:all)
      end
      it { should assign_to(:users).with(users)} 
      it { should respond_with(:success) }
    end
  end
end
