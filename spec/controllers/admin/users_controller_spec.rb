require 'spec_helper'

describe Admin::UsersController do

  include Devise::TestHelpers

  describe "routes" do
    it { should route(:get, "/admin/users").to(:action => 'index') }
  end

  describe 'admin role' do
    before do
      @user = Factory :user, :roles => [ 'admin' ]
      sign_in @user 
    end

    describe 'index' do
      let(:users) { [stub] }
      before do
        User.expects(:ascending).returns(scope = mock)
        scope.expects(:paginate).with(:page => 3, :per_page => 10).returns(users)
        get :index, :page => 3
      end 
      it { should assign_to(:users).with(users)} 
      it { should respond_with(:success) }
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
          get :index, :page => 3
        end
        it { should redirect_to(page_path('access_denied')) }
      end
    end
  end

  describe 'anonymous user' do
    describe 'index' do
      before do
        get :index, :page => 3
      end
      it { should redirect_to(page_path('access_denied_anonymous')) }
    end
  end
end
