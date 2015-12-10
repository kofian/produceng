require 'spec_helper'

describe CatarseBraintree::Request::Payment do
  subject { described_class.new(params) }


  describe '#transaction' do
    let(:params) { {payment_method_nonce: 'NONCE'} }
    let(:contribution) { double(value: 1001.82) }

    before(:each) do
      subject.stub(:contribution).and_return(contribution)
    end

    it 'should create a new transaction' do
      Braintree::Transaction.should_receive(:sale).with({
        amount: 1001.82,
        payment_method_nonce: 'NONCE'
      }).and_return(true)

      subject.transaction.should be_true
    end
  end


  describe '#result' do
    let(:params) { {} }
    let(:transaction_data) { double(id: 'TRANSACTION ID') }
    let(:transaction) { double(transaction: transaction_data) }
    let(:contribution) { double }

    before(:each) do
      subject.stub(:contribution).and_return(contribution)
      subject.stub(:transaction).and_return(transaction)

      contribution.stub(:update_attributes)
      contribution.stub(:confirm!)
    end

    describe 'with a succesful transaction' do
      before(:each) do
        transaction.stub(:success?).and_return(true)
      end

      it 'should return the transaction' do
        subject.result.should eql(transaction)
      end

      it 'should confirm the contribution' do
        contribution.should_receive(:confirm!)
        subject.result
      end

      it 'should update the contribution payment attributes' do
        contribution.should_receive(:update_attributes).with({
          payment_id: 'TRANSACTION ID',
          payment_method: 'Braintree'
        }).and_return(true)

        subject.result
      end
    end

    describe 'with a failed transaction' do
      before(:each) do
        transaction.stub(:success?).and_return(false)
      end

      it 'should not update the contribution' do
        contribution.should_not_receive(:confirm!)
        contribution.should_not_receive(:update_attributes)
        subject.result
      end

      it 'should return the transaction' do
        subject.result.should eql(transaction)
      end
    end
  end

  describe '#contribution' do
    let(:params) { {id: 'PAYMENT ID'} }

    it 'should find and return the contribution' do
      PaymentEngines.should_receive(:find_payment).with({id: 'PAYMENT ID'}).and_return true
      subject.contribution.should be_true
    end
  end
end
