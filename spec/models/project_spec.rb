require "spec_helper"

describe Project do
  let(:project) { Factory(:project, :organization => Factory.build(:organization)) }

  it { should belong_to(:organization) }
  it { should have_many(:donations) }
end

describe Project, "amount raised" do
  subject { Factory(:project, :goal => 1000) }

  before do
    Factory(:donation, :amount => 200, :project => subject)
    Factory(:donation, :amount => 300, :project => subject)
  end

  its(:amount_raised)  { should == 500 }
  its(:percent_raised) { should == 50.0 }
end

describe Project, "percent raised when goal is 0" do
  subject { Factory.build(:project, :goal => 0) }

  its(:percent_raised) { should be_zero }
end
