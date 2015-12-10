module CatarseBraintree
  class BackerCheckWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(project_id)
      project = Project.find(project_id)
      CatarseBraintree::Service::Backer::Check.new(project).perform
    end
  end
end
