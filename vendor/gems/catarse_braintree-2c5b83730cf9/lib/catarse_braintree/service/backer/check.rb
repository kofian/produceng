module CatarseBraintree
  module Service
    module Backer

      class Check < CatarseBraintree::Service::Backer::Base
        attr_reader :failed_backers

        def initialize(project)
          super(project)
          @failed_backers = []
        end

        def auth_card(backer)
          CatarseBraintree::Request::Payment.new({
            id: backer.id
          })
        end

        def void_card(backer)
          CatarseBraintree::Request::Void.new({
            id: backer.id
          })
        end

        def perform
          each_backer do |backer|
            begin
              next unless backer.payment_method == 'Braintree'
              next unless backer.bt_customer_token.present?

              if auth_card(backer).success?
                puts "**** [Braintree] Backer #{backer.id} paid. Voiding"
                void_card(backer).result
              else
                puts "**** [Braintree] Backer #{backer.id} failed"
                backer.cancel!
                @failed_backers << backer
              end
            end
          end

          failed_backers.empty?
        end
      end

    end
  end
end

