module CatarseBraintree
  module Request

    class Settle < CatarseBraintree::Request::Base
      def transaction
        @transaction ||= Braintree::Transaction.find(contribution.payment_id)
      end

      def settle_transaction
         Braintree::Transaction.submit_for_settlement(transaction.id)
      end

      def result
        puts "[Braintree] Settling #{transaction.id}"
        void_result = void_transaction
        if void_result.success?
          puts "[Braintree] Settled #{transaction.id}"
        else
          puts "[Braintree] Could not settle #{transaction.id}"
        end

        void_result
      end
    end

  end
end



