require 'spec_helper'

class Payment < ActiveRecord::Base
  acts_as_amazon_payment
end

ActiveRecord::Base.connection.create_table :payments do |t|
  t.column :amount,         :integer
  t.column :transaction_id, :string
  t.column :request_id,     :string
  t.column :status,         :string
end

describe AmazonFPS do

  before do
    @api = stub
    Remit::API.stubs(:new => @api)
  end

  let(:payment) { Payment.new }

  describe 'authorize' do
    before do
      pipeline = stub
      pipeline.stubs(:url => 'return url')
      @api.stubs(:get_single_use_pipeline => pipeline)
      payment.stubs(:recipient_token_id => 3)
    end
    it 'should use a single use pipeline' do
      token = payment.authorize('http://test.com/authorize_donation')
      token.url.should == 'return url'
      @api.should have_received(:get_single_use_pipeline)
    end
  end

  describe 'confirm' do
    before do
      payment.stubs(:caller_token_id => 4)
      payment_token = Struct::PaymentToken.new('http://some.url', 4)
      pipeline_response = stub
      Remit::PipelineResponse.stubs(:new => pipeline_response)
      pipeline_response.stubs(:tokenID => 5)
      pay_response = stub
      @api.stubs(:pay => pay_response)
      transaction_response = stub
      pay_response.stubs(:transaction_response => transaction_response)
      transaction_response.stubs(:transaction_id)
      pay_response.stubs(:request_id)
      pay_response.stubs(:status)
      payment.confirm('http://long.url/from/amazon', payment_token)
    end
    it 'should parse the pipeline response and make the pay request' do
      Remit::PipelineResponse.should have_received(:new).with('http://long.url/from/amazon', AMAZON_SECRET_KEY)
      @api.should have_received(:pay)
    end
  end
end
