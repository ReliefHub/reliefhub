require 'spec_helper'

describe User do
  it { should have_many(:donations) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end

describe User, "#unique_projects" do
  subject       { Factory(:user)    }
  let(:project) { Factory(:project) }

  before do
    2.times do
      Factory(:donation, :user => subject, :project => project)
    end
  end

  it "returns only unique projects" do
    subject.unique_projects.should == [project]
  end
end

describe User, "ROLES" do
  it 'should define all of the application roles' do
    User::ROLES.include?('admin').should be_true
    User::ROLES.include?('field_operator').should be_true
    User::ROLES.include?('organization_manager').should be_true
  end

  it 'should not define any unneeded roles' do
    (User::ROLES - %w[admin field_operator organization_manager]).should == []
  end
end

describe User, "roles assigned as an array" do
  subject { Factory :user, :roles => [ 'field_operator' ] }
  it 'should have all of the roles assigned and not others' do
    subject.roles.include?('admin').should be_false
    subject.is?('admin').should be_false
    subject.roles.include?('field_operator').should be_true
    subject.is?('field_operator').should be_true
    subject.roles.include?('organization_manager').should be_false
    subject.is?('organization_manager').should be_false
  end
end

describe User, "roles assigned as a string" do
  subject { Factory :user, :roles => "field_operator" }
  it 'should have all of the roles assigned and not others' do
    subject.roles.include?('admin').should be_false
    subject.is?('admin').should be_false
    subject.roles.include?('field_operator').should be_true
    subject.is?('field_operator').should be_true
    subject.roles.include?('organization_manager').should be_false
    subject.is?('organization_manager').should be_false
  end
end

describe User, "ascending sort order" do
  it 'should use the proper SQL ORDER BY clause' do
    User.ascending.to_sql.should match 'ORDER BY\s+last_name,\s+first_name'
  end
end
