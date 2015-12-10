class CatarseBraintree::BraintreeController < ApplicationController
  skip_before_filter :force_http
  SCOPE = "projects.contributions.checkout"
  layout :false

  def review
    @contribution = Contribution.find(params[:id])
    @project = @contribution.project
  end

  def charge
    @client_token = gateway.generate_client_token
  end

  def pay
    payment = ::CatarseBraintree::Request::PaymentMethod.new(params)
    contribution = payment.contribution

    if payment.success?
      flash[:success] = I18n.t('success', scope: SCOPE)
      redirect_to main_app.project_contribution_path(contribution.project, contribution)
    else
      flash[:failure] = I18n.t('braintree_error', scope: SCOPE)
      redirect_to main_app.project_contribution_path(contribution.project)
    end
  end

  def cancel
    flash[:failure] = I18n.t('braintree_cancel', scope: SCOPE)
    redirect_to main_app.project_contribution_path(contribution.project)
  end

  protected

  def gateway
      @gateway ||= CatarseBraintree::Gateway.instance
  end
end
