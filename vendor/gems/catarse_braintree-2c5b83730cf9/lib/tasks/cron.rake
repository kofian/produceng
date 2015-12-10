desc "Check payment ststus for all projects"
task check_payments: :environment do
  Project.with_state('online').find_in_batches do |batch|
    batch.each do |project|
      CatarseBraintree::BackerCheckWorker.perform_async(project.id)
    end
  end
end
