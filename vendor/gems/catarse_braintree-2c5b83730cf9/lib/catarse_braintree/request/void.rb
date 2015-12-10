module CatarseBraintree
  module Request

    class Void < CatarseBraintree::Request::Base
      def transaction
        @transaction ||= Braintree::Transaction.find(contribution.payment_id)
      end

      def void_transaction
         Braintree::Transaction.void(transaction.id)
      end

      def result
        puts "[Braintree] Voiding #{transaction.id}"
        void_result = void_transaction
        if void_result.success?
          contribution.update_attributes({
            payment_id: nil
          })
        else
          puts "Could not void #{transaction.id}"
        end

        void_result
      end
    end

  end
end


