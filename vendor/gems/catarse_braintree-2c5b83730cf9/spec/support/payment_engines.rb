# dummy class to be stubbed should use interface defined in Catarse
class PaymentEngines
  class Interface
  end

  def self.configuration
    {
      braintree_test: 1,
      braintree_merchant_id: 'MERCHANT ID',
      braintree_private_key: 'PRIVATE KEY',
      braintree_public_key: 'PUBLIC KEY',
    }
  end
end
