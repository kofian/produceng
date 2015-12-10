module CatarseBraintree
  class RefundWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(backer_id)
      backer = Backer.find(backer_id)
      CatarseBraintree::Service::Backer::Refund.perform(backer)
    end
  end
end

