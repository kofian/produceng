Braintree::Configuration.environment = :production
Braintree::Configuration.merchant_id = ENV['merchant_id']
Braintree::Configuration.public_key = ENV['braintree_public_key']
Braintree::Configuration.private_key = ENV['braintree_private_key']