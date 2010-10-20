require "spec_helper"
describe Project do

  let(:project) { Factory :project, :organization=>Factory.build(:organization) }
  
  it 'should belong to an organization' do
    project.organization.projects.should include project
  end
  
  it 'should compute funds received based on donations' do
    project = Factory :project, :organization=>Factory.build(:organization),
                      :donations   =>[Factory.build(:donation, :amount=>100),
                                      Factory.build(:donation, :amount=>200)]
    project.raised.should == 300
  end
  
  it 'indicates percent raised' do
    project = Factory.build(:project, :goal => 2000)
    project.stubs(:raised => 1000)
    project.percent_completed.should == 50
  end
  
  it 'rounds percision' do
    project = Factory.build(:project, :goal => 2730)
    project.stubs(:raised => 417)
    project.percent_completed.should == 16
  end

  it 'indicates 0 percent raised if there is no data' do
    project = Factory.build(:project, :goal => 100)
    project.stubs(:raised => 0)
    project.percent_completed.should == 0
  end
  
end