require 'spec_helper'

describe CatarseBraintree::BraintreeController, type: :controller do
  let(:main_app) { double }
  let(:project) { double(id: 1111) }
  let(:contribution) { double(id: 1234, project: project, value: 100.21) }

  before(:each) do
    # Setting up routing stubs
    controller.stub(:main_app).and_return(main_app)
    main_app.stub(:project_backer_path).with(project, contribution).and_return('backer path')
    main_app.stub(:new_project_backer_path).with(project).and_return('new backer path')

    PaymentEngines.stub(:find_payment).and_return(contribution)
    PaymentEngines.stub(:create_payment_notification)
  end

  describe 'GET #review' do
    before(:each) do
      get :review, id: contribution.id, use_route: 'catarse_braintree'
    end

    it 'should render succesfully' do
      response.should be_success
      response.should render_template(:review)
    end
  end

  describe 'GET #charge' do
    let(:nonce) { 'NONCE' }

    before(:each) do
      Braintree::ClientToken.stub(:generate).and_return(nonce)
      post :charge, id: contribution.id, use_route: 'catarse_braintree'
    end

    it 'should setup the nonce' do
      assigns(:client_token).should eql('NONCE')
    end

    it 'should render succesfully' do
      response.should be_success
      response.should render_template(:charge)
    end
  end


  describe 'POST #pay' do
    let(:payment) { double(contribution: contribution) }
    let(:send_action) { post :pay, payment_method_nonce: 'NONCE', id: contribution.id, use_route: 'catarse_braintree' }

    before(:each) do
      CatarseBraintree::Request::Payment.stub(:new).and_return(payment)
    end

    describe 'with a successful transaction' do
      before(:each) do
        payment.stub(:success?).and_return(true)
      end

      it 'should set the flash to the success message' do
        send_action
        controller.flash[:success].should eql('Your back was successfully made. Thanks a lot!')
      end

      it 'should redirect to the project page' do
        send_action
        response.should redirect_to 'backer path'
      end
    end

    describe 'with a failed transaction' do
      before(:each) do
        payment.stub(:success?).and_return(false)
      end

      it 'should set the flash to the error message' do
        send_action
        controller.flash[:failure].should eql('Ooops. There was an error while sending your payment. Please try again.')
      end

      it 'should redirect to the new contribution page' do
        send_action
        response.should redirect_to 'new backer path'
      end
    end
  end
end
