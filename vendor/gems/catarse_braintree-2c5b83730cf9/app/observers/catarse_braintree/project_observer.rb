class CatarseBraintree::ProjectObserver < ActiveRecord::Observer
  observe :project

  def from_waiting_funds_to_successful(project)
    puts "*********************************"
    puts "\n\n [Braintree] Project successful. Taking payment. \n\n"
    puts "*********************************"
    Rails.logger.debug "[Braintree] Project successful. Taking payment."
    PaymentReceiverWorker.perform_async(project.id)
  end
end
