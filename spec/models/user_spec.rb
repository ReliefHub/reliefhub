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
