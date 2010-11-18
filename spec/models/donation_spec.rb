require 'spec_helper'

describe Donation do
  subject { Factory.build(:donation) }

  it { should belong_to(:project) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:project) }

  describe 'parsing transation amount from Amazon' do
    before do
      subject.transaction_amount = 'USD 140'
    end
    its(:amount) { should == 140 }
  end

  describe 'parsing transation amount from Amazon without a currency' do
    before do
      subject.transaction_amount = '1340'
    end
    its(:amount) { should == 1340 }
  end

  describe 'parsing transation amount with an unexpected currency from Amazon' do
    before do
      subject.amount = nil
      subject.transaction_amount = 'EUR 140'
    end
    its(:amount) { should be_nil }
  end
end
