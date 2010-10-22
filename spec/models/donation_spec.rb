require 'spec_helper'

describe Donation do
  subject { Factory(:donation) }

  it { should belong_to(:project) }
  it { should belong_to(:user) }
end
