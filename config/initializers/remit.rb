config_file = File.join(Rails.root, 'config', 'amazon_fps.yml')
config = YAML.load_file(config_file)[Rails.env].symbolize_keys

AMAZON_ACCESS_KEY = config[:access_key]
AMAZON_SECRET_KEY = config[:secret_key]

