module CatarseBraintree
  module Service

    class Base
      def valid?
        true
      end

      def perform
        raise 'Needs overriding'
      end

      def result
        valid? ? perform : false
      end
    end

  end
end
