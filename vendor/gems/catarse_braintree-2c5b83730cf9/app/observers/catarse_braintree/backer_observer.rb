class CatarseBraintree::BackerObserver < ActiveRecord::Observer
  observe :contribution

  def from_requested_refund_to_refunded
    Rails.logger.debug "[Braintree] Queued refund job"
    RefundWorker.perform_async(contribution.id)
  end

  def from_confirmed_to_refunded
    Rails.logger.debug "[Braintree] Queued refund job"
    RefundWorker.perform_async(contribution.id)
  end
end
