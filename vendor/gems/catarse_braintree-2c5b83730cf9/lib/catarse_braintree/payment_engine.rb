module CatarseBraintree
  class PaymentEngine

    def name
      'Braintree'
    end

    def review_path(contribution)
      CatarseBraintree::Engine.routes.url_helpers.review_braintree_path(contribution)
    end

    def can_do_refund?
      true
    end

    def direct_refund contribution
      CatarseBraintree::ContributionActions.new(contribution).refund
    end

    def locale
      'en'
    end

  end
end

