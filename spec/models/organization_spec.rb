require "spec_helper"

describe Organization do
  subject { Factory(:organization) }

  before do
    2.times { Factory(:project, :organization => subject) }
  end

  its(:projects_count) { should == 2 }
end

describe Organization, "address" do
  subject { Factory.build :organization,
                          :street1 => '123 Main St', :street2 => '',
                          :city => 'Cambridge', :state => 'MA', :zip => '02138',
                          :country => "USA" }

  its(:address) { should == '123 Main St, Cambridge, MA, 02138, USA' }
end
