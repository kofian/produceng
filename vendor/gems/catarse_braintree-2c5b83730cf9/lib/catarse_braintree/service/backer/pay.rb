module CatarseBraintree
  module Service
    module Backer

      class Pay < CatarseBraintree::Service::Backer::Base
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

        def settle_backer(backer)
          CatarseBraintree::Request::Settle.new({
            id: backer.id
          })
        end

        def perform
          each_backer do |backer|
            begin
              next unless backer.payment_method == 'Braintree'
              next unless backer.bt_customer_token.present?

              if auth_card(backer).success?
                puts "**** [Braintree] Backer #{backer.id} paid."
              else
                puts "**** [Braintree] Backer #{backer.id} failed"
                backer.cancel!
                @failed_backers << backer
              end
            end
          end

          succesful = failed_backers.empty?

          if succesful
            # Now we have the full amount, we should settle the transactions
            each_backer do |backer|
              settle_backer(backer)
            end
          else
            # TODO: What do we do if the total isn't fully recouped?
          end

          succesful
        end
      end

    end
  end
end


