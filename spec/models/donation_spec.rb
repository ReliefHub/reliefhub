require 'spec_helper'

describe Donation do
  subject { Factory(:donation) }

  it { should belong_to(:project) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:project) }
end
