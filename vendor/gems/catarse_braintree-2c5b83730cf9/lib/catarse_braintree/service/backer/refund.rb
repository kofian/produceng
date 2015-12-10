module CatarseBraintree
  module Service
    module Backer

      class Refund < CatarseBraintree::Service::Backer::Base
        attr_reader :backer

        def initialize(backer)
          @backer = backer
          super(backer.project)
        end

        def refund_transaction
          CatarseBraintree::Request::Refund.new({
            id: backer.payment_id
          })
        end

        def perform
          refund_transaction.result
        end
      end

    end
  end
end


