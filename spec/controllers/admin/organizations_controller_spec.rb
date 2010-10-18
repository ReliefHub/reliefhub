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
  
end
