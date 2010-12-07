require 'spec_helper'

describe DonationsController do

  describe "routes" do
    it { should route(:get, "/donations/confirm").to(:action => 'confirm') }
    it { should route(:get, "/donations/abandon").to(:action => 'abandon') }
  end

  describe 'confirm a donation' do
    before do
      @current_user = stub
      controller.stubs(:current_user => @current_user)
      @donation = mock
    end

    AMAZON_RETURN_URL_PARAMS = {
      "paymentReason"     => "Haiti Earthquake Relief",
      "buyerName"         => "Pat Shaughnessy",
      "signatureVersion"  => "2",
      "transactionDate"   => "1289833645",
      "certificateUrl"    => "https://fps.sandbox.amazonaws.com/certs/090910/PKICert.pem?requestId=bjymm6f2hc1cdrkj7cm8vrqu0ilhnmg15drctudlmkwd5k5arzp",
      "recipientName"     => "ReliefHub.org",
      "signature"         => "ys+CLudfvbP72qOCXQQvVVdAtqYt8jpf3hYV/+xh8FQpRusPHprTdpwwVPnJCyw2DT/8oAL/hm4U\nTFG2z4029bMswLtS6A+F+Q+hgvwRvxA5BkOH/adg+5FlTJ0t8OBNipZDIIL0RwSIYeDbPVPk0k0S\nDESPBjVehyvEhkbZJa8=",
      "transactionAmount" => "USD 122",
      "recipientEmail"    => "info@reliefhub.org",
      "signatureMethod"   => "RSA-SHA1",
      "transactionId"     => "15H8171G3PNH8LL41ZSGQRP32R4IN2GU83J",
      "referenceId"       => "451234",
      "paymentMethod"     => "Credit Card",
      "operation"         => "pay",
      "buyerEmail"        => "pat@patshaughnessy.net",
      "status"            => "PS"
    }

    describe 'success' do
      before do
        projects = stub
        Project.expects(:where => projects).with(:id => "451234")
        project = stub
        projects.expects(:first => project)
        Donation.expects(:new => @donation).with({
          :transaction_amount => 'USD 122',
          :project => project,
          :user => @current_user,
          :transaction_id => '15H8171G3PNH8LL41ZSGQRP32R4IN2GU83J',
          :status => 'PS'
        })
        @donation.expects(:save => true)
        get :confirm, AMAZON_RETURN_URL_PARAMS
      end
      it { should redirect_to(page_path('thank_you')) }
    end

    describe 'failure' do
      before do
        Project.expects(:where => []).with(:id => "9876")
        Donation.expects(:new => @donation).with({
          :transaction_amount => 'USD 122',
          :project => nil,
          :user => @current_user,
          :transaction_id => '15H8171G3PNH8LL41ZSGQRP32R4IN2GU83J',
          :status => 'PS'
        })
        @donation.expects(:save => false)
        get :confirm, AMAZON_RETURN_URL_PARAMS.merge("referenceId" => "9876")
      end
      it { should redirect_to(page_path('donation_error')) }
    end

    describe 'missing project id' do
      before do
        Donation.expects(:new => @donation).with({
          :transaction_amount => 'USD 122',
          :project => nil,
          :user => @current_user,
          :transaction_id => '15H8171G3PNH8LL41ZSGQRP32R4IN2GU83J',
          :status => 'PS'
        })
        @donation.expects(:save => false)
        get :confirm, AMAZON_RETURN_URL_PARAMS.merge("referenceId" => nil)
      end
      it { should redirect_to(page_path('donation_error')) }
    end
  end

  describe 'abandon a donation' do
    before do
      get :abandon
    end

    it { should redirect_to(page_path('donation_error')) }
  end
end
