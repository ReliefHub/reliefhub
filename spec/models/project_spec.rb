require 'spec_helper'

describe Project do
  let(:project) { Factory :project, :organization=>Factory.build(:organization) }
  
  it 'should belong to an organization' do
    project.organization.projects.should include project
  end
  
  it 'should compute funds received based on donations' do
    pending 'we do not have dontations yet'
  end
end
