require 'spec_helper'

describe DonationsController do

  let(:donation) { Factory.build(:donation) }
  let(:payment_token) { stub }

  describe "routes" do
    it { should route(:post, "/donations").to(:action => 'create') }
  end
end
