module CatarseBraintree
  module Request

    class Base
      attr_reader :options

      def initialize(options = {})
        @options = options.with_indifferent_access
      end

      def result
        raise 'Needs overriding'
      end

      def success?
        result.success?
      end

      def contribution
        @contribution ||= ::PaymentEngines.find_payment(id: options[:id])
      end
    end

  end
end
