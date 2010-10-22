require 'spec_helper'

describe DonationsController do

  AMAZON_URL = 'http://amazon.com'

  let(:donation) { Factory.build(:donation) }
  let(:payment_token) { stub }

  describe "routes" do
    it { should route(:post, "/donations").to(:action => 'create') }
  end

  describe 'creating a donation' do
    before do
      Donation.stubs(:new=>donation)
      donation.stubs(:to_param => '1')
      payment_token.stubs(:url => AMAZON_URL)
    end

    describe 'successful authorization' do
      before do
        donation.stubs(:save=>true)
        donation.stubs(:authorize => payment_token)
        post :create
      end
      it 'should call authorize with the proper return url' do
        donation.should have_received(:authorize).with(confirm_donation_url(donation))
      end
      it { should redirect_to(AMAZON_URL) }
      it 'should save the payment token in the session' do
        session[:payment].should == payment_token
      end
    end

    describe 'failed authorization' do
      before do
        donation.stubs(:save=>true)
        donation.stubs(:authorize => nil)
        post :create
      end
      it 'should call the Amazon service with the proper return url' do
        donation.should have_received(:authorize).with(confirm_donation_url(donation))
      end
      it { should render_template(:new) }
      it 'should clear the payment token in the session' do
        session[:payment].should be_nil
      end
    end

    describe 'invalid donation' do
      before do
        donation.stubs(:save=>false)
        donation.stubs(:authorize => AMAZON_URL)
        post :create
      end
      it 'should not call the Amazon service at all' do
        donation.should_not have_received(:authorize)
      end
      it { should render_template(:new) }
      it 'should clear the payment token in the session' do
        session[:payment].should be_nil
      end
    end
  end

  describe 'confirming a donation' do
    before do
      Donation.stubs(:find=>donation)
      session[:payment] = payment_token
    end

    describe 'successful confirmation' do
      before do
        donation.stubs(:confirm => true)
        get :confirm, :id => '1'
      end
      it 'should call the Amazon service with the proper return url' do
        donation.should have_received(:confirm).with(request.url, payment_token)
      end
      it { should redirect_to(root_url) }
    end

    describe 'invalid confirmation' do
      before do
        donation.stubs(:confirm => false)
        get :confirm, :id => '1'
      end
      it 'should call the Amazon service with the proper return url' do
        donation.should have_received(:confirm).with(request.url, payment_token)
      end
      it { should render_template(:new) }
    end

    describe 'invalid donation' do
      before do
        Donation.stubs(:find=>nil)
        get :confirm, :id => '1'
      end
      it 'should not call the Amazon service' do
        donation.should_not have_received(:confirm)
      end
      it { should render_template(:new) }
    end

  end
end

