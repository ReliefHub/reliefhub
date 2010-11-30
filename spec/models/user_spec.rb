require 'spec_helper'

describe User do
  it { should have_many(:donations) }
end

describe User, 'details' do
  subject { Factory.build :user,
                          :first_name => 'Stevie',
                          :last_name => 'Wonder',
                          :email => 'steviewonder@gmail.com',
                          :password => 'stevieisthebest1'
                          }
                          
  its(:details) { should == 'Stevie, Wonder, steviewonder@gmail.com, stevieisthebest1' }
end