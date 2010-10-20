require 'spec_helper'

describe OrganizationPhoto do
  let(:organization_photo) { Factory.build(:organization_photo) }
  let(:organization) { Factory :organization, :organization_photos=>[organization_photo] }

  it 'should belong to an organization' do
    organization.organization_photos.should include organization_photo
  end
  
end
