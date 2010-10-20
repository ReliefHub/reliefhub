require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper') 
describe Admin::OrganizationsController do 

  describe 'index' do

    let(:organizations) { [stub] }
    before do
      Organization.stubs(:all).returns(organizations)
      get :index 
    end 
    it "should have called organization.all" do
      Organization.should have_received(:all)
    end
    it { should assign_to(:organizations).with(organizations)} 
    it { should respond_with(:success) }
  end
  
  describe 'new' do
    let(:organization) { Factory.build(:organization) }

    before do
      Organization.stubs(:new=>organization)
      get :new
    end
    it { should assign_to(:organization).with(organization)}

  end
  
  describe 'create' do
    let(:organization) { Factory.build(:organization) }
    before do
      @data = stub
      Organization.stubs(:new=>organization)
      organization.stubs(:name=>'my orphanage')
    end

    describe 'succeeds' do
      before do
        organization.stubs(:save=>true)
        post :create, :organization=>@data
      end
      it { should redirect_to(admin_organizations_path) }
      it { should set_the_flash.to("Successfully created a new organizations called my orphanage") }
    end

    describe 'failing' do
      before do
        organization.stubs(:save=>false)
        post :create, :organization=>@data
      end
      it { should render_template(:new) }
    end  
  end
  
  describe 'show' do
    let(:organization) { Factory.stub(:organization) }

    before do
      Organization.stubs(:find=>organization)
      get :show, :id=>organization.id
    end
    it { should assign_to(:organization).with(organization)}
    it { should respond_with(:success) }
  end

  describe 'edit' do
    let(:organization) { Factory.stub(:organization) }

    before do
      Organization.stubs(:find=>organization)
      get :edit, :id=>organization.id
    end
    it { should assign_to(:organization).with(organization)}
    it { should respond_with(:success) }
  end

  describe 'update' do
    let(:organization) {Factory.build(:organization,:name=>"my orphanage")}
    before do 
      @data = stub
      Organization.stubs(:find=>organization)
    end
    describe 'failing' do
      before do
        put :update, :id=>1, :organization=>@data
      end
      it { should redirect_to(admin_organization_path) }
      it { should set_the_flash.to("Successfully changed my orphanage") }
    end
    describe 'failing' do
      before do
        organization.stubs(:save=>false)
        put :update, :id=>1, :organization=>@data
      end
      it { should render_template(:edit) }
    end
  end
end
