module BraintreePayment

  def create_update_sub_merchant(options = {})

    if options[:braintree_id].present?
      result = Braintree::MerchantAccount.update(
        options[:braintree_id],
        :individual => options[:individual] || {},
        :business => options[:business] || {},
        :funding => options[:funding] || {}
      )
    else
      result = Braintree::MerchantAccount.create(
        :individual => options[:individual] || {},
        :business => options[:business] || {},
        :funding => options[:funding] || {},
        :tos_accepted => true,
        :master_merchant_account_id => ENV['master_merchant_account_id']
      )
    end
    return result
  end
end