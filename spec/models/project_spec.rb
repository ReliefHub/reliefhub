require 'spec_helper'

describe Project do
  let(:project) { Factory :project, :organization=>Factory.build(:organization) }
  
  it 'should belong to an organization' do
    project.organization.projects.should include project
  end
end
