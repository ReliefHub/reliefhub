require "spec_helper"
describe Organization do
  let(:organization) { Factory.build :organization, :street1=>'123 main', :street2=>'', :city=>'cambridge', :state=>'mass', :zip=>'02138', :country=>"USA"}
  it 'should combine address fields into a single address' do
    organization.address.should == '123 main, cambridge, mass, 02138, USA'
  end
  
  it 'should return the number of projects' do
    organization.projects_count.should == 0
    pending("implement when we integrate projects")
  end
    
  
end
