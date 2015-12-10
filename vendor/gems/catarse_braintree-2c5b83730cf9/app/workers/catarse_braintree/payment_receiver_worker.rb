module CatarseBraintree
  class PaymentReceiverWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(project_id)
      project = Project.find(project_id)
      CatarseBraintree::Service::Backer::Pay.perform(project)
    end
  end
end
