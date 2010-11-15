config_file = File.join(Rails.root, 'config', 'amazon_simple_pay.yml')
config = YAML.load_file(config_file)[Rails.env].symbolize_keys

AMAZON_ACCESS_KEY = config[:access_key]
AMAZON_PAYMENTS_ACCOUNT_ID = config[:amazon_payments_account_id]

