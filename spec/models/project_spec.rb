require "spec_helper"
describe Project do

  let(:project) { Factory :project, :organization=>Factory.build(:organization) }
  
  it 'should belong to an organization' do
    project.organization.projects.should include project
  end
  
  it 'should compute funds received based on donations' do
    pending 'we do not have dontations yet'
  end

  it 'returns projects by the amount raised' do
    project_1000_raised = Factory.create(:project, :raised => 1000)
    project_3000_raised = Factory.create(:project, :raised => 3000)
    Project.by_raised_amount.first.should == project_3000_raised
    Project.by_raised_amount.last.should  == project_1000_raised
  end
  
  it 'indicates percent raised' do
    project = Factory.build(:project, :raised => 1000, :goal => 2000)
    project.percent_completed.should == 50
  end
  
  it 'rounds percision' do
    project = Factory.build(:project, :raised => 417, :goal => 2730)
    project.percent_completed.should == 16
  end

  it 'indicates 0 percent raised if there is no data' do
    project = Factory.build(:project, :raised => 0, :goal => 100)
    project.percent_completed.should == 0
  end
  
end