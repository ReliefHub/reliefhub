config_file = File.join(Rails.root, 'config', 'amazon_simple_pay.yml')
config = YAML.load_file(config_file)[Rails.env].symbolize_keys

AMAZON_ACCESS_KEY = config[:access_key]
AMAZON_PAYMENTS_ACCOUNT_ID = config[:amazon_payments_account_id]

#eval environment variables if set in config file
AMAZON_ACCESS_KEY = eval(AMAZON_ACCESS_KEY) if AMAZON_ACCESS_KEY.include?("ENV[")
AMAZON_PAYMENTS_ACCOUNT_ID = eval(AMAZON_PAYMENTS_ACCOUNT_ID) if AMAZON_PAYMENTS_ACCOUNT_ID.include?("ENV[")
