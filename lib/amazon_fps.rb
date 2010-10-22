# TODO extract this module as a gem
module AmazonFPS

  # TODO make this an option on acts_as_amazon_payment
  APP_NAME = 'ReliefHub'

  Struct.new("PaymentToken", :url, :recipient_token)

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_amazon_payment
      include InstanceMethods
    end
  end

  module InstanceMethods

    def authorize(return_url)
      recipient_token = recipient_token_id
      single_use_pipeline = api.get_single_use_pipeline(
        :caller_reference   => (caller_reference+2).to_s,
        :recipient_token    => recipient_token,
        :transaction_amount => amount,
        :return_url         => return_url,
        :caller_key         => AMAZON_ACCESS_KEY
      )
      Struct::PaymentToken.new(single_use_pipeline.url, recipient_token)
    end

    def confirm(url, payment_token)

      pipeline_response = Remit::PipelineResponse.new(
        url,
        AMAZON_SECRET_KEY
      )

      request = Remit::Pay::Request.new(
        :caller_token_id    => caller_token_id,
        :recipient_token_id => payment_token.recipient_token,
        :sender_token_id    => pipeline_response.tokenID,
        :transaction_amount => Remit::RequestTypes::Amount.new(
          :amount => amount,
          :currency_code => "USD"
        ),
        :charge_fee_to      => "Recipient",
        :caller_reference   => caller_reference
      )

      pay_response = api.pay(request)

      # TODO these field names should be options on acts_as_amazon_payment
      self.transaction_id = pay_response.transaction_response.transaction_id
      self.request_id = pay_response.request_id
      self.status = pay_response.status
      save
      status == 'Success'
    end

    private

    def recipient_token_id
      request = Remit::InstallPaymentInstruction::Request.new(
        :payment_instruction => "MyRole == 'Recipient' orSay 'Role does not match';",
        :caller_reference => caller_reference.to_s,
        :token_friendly_name => "#{APP_NAME} recipient token",
        :token_type => "Unrestricted"
      )
      api.install_payment_instruction(request).token_id
    end

    def caller_token_id
      request = Remit::InstallPaymentInstruction::Request.new(
        :payment_instruction => "MyRole == 'Caller' orSay 'Role does not match';",
        :caller_reference => (caller_reference+1).to_s,
        :token_friendly_name => "#{APP_NAME} caller token",
        :token_type => "Unrestricted"
      )
      api.install_payment_instruction(request).token_id
    end

    def api
      @api ||= Remit::API.new(AMAZON_ACCESS_KEY, AMAZON_SECRET_KEY, true)
    end

    def caller_reference
      @ref ||= Time.now.to_i
    end

  end
end

