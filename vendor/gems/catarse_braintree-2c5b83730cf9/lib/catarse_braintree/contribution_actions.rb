module CatarseBraintree
  class ContributionActions

    def initialize(contribution)
      @contribution = contribution
    end

    def refund
      refund_request = gateway.refund(nil, @contribution.payment_id)
      refund_request.success?
    end

    private

    def gateway
      @gateway ||= CatarseBraintree::Gateway.instance
    end

  end
end

