module CatarseBraintree
  module Request

    class Payment < CatarseBraintree::Request::Base
      def transaction
        @transaction ||= Braintree::Transaction.sale(
          amount: contribution.value,
          customer_id: contribution.bt_customer_token,
          options: {
            submit_for_settlement: !!options[:settle]
          }
        )
      end

      def result
        puts "[Braintree] Paying #{contribution.id}"
        if transaction.success?
          puts "[Braintree] Paid with Tx #{transaction.transaction.id}"
          contribution.update_attributes({
            payment_id: transaction.transaction.id
          })
        end

        transaction
      end
    end

  end
end

