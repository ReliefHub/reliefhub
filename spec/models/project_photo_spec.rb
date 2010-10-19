require 'spec_helper'

describe ProjectPhoto do
  let(:project_photo) { Factory.build(:project_photo) }
  let(:project) { Factory :project, :project_photos=>[project_photo] }
  
  it 'should belong to a project' do
    project.project_photos.should include project_photo
  end
  
end
