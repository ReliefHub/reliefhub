require 'spec_helper'

describe AmazonSimplePayHelper do

  EXPECTED_AMAZON_FORM = <<HTML
<form action=\"https://authorize.payments-sandbox.amazon.com/pba/paypipeline\" method=\"post\"><input id=\"amount\" name=\"amount\" type=\"text\" /><input id=\"accessKey\" name=\"accessKey\" type=\"hidden\" value=\"TEST_ACCESS_KEY\" /><input id=\"amazonPaymentsAccountId\" name=\"amazonPaymentsAccountId\" type=\"hidden\" value=\"TEST_ACCOUNT_ID\" /><input id=\"immediateReturn\" name=\"immediateReturn\" type=\"hidden\" value=\"1\" /><input id=\"processImmediate\" name=\"processImmediate\" type=\"hidden\" value=\"1\" /><input id=\"isDonationWidget\" name=\"isDonationWidget\" type=\"hidden\" value=\"1\" /><input id=\"cobrandingStyle\" name=\"cobrandingStyle\" type=\"hidden\" value=\"logo\" /><input id=\"returnUrl\" name=\"returnUrl\" type=\"hidden\" value=\"http://test.host/donations/confirm\" /><input id=\"abandonUrl\" name=\"abandonUrl\" type=\"hidden\" value=\"http://test.host/donations/abandon\" /></form>
HTML

  it 'should return the proper form' do
    helper.amazon_simple_pay_form_tag do
      text_field_tag 'amount'
    end.should == EXPECTED_AMAZON_FORM.strip
  end
end
