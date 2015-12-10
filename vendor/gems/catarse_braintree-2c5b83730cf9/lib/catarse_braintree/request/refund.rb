module CatarseBraintree
  module Request

    class Refund < CatarseBraintree::Request::Base
      def transaction
        @transaction ||= Braintree::Transaction.find(contribution.payment_id)
      end

      def void_transaction
         Braintree::Transaction.refund(transaction.id)
      end

      def result
        puts "[Braintree] Refunding #{transaction.id}"
        void_result = void_transaction
        if void_result.success?
          contribution.update_attributes({
            payment_id: nil
          })
        else
          puts "Could not refund #{transaction.id}"
        end

        void_result
      end
    end

  end
end


