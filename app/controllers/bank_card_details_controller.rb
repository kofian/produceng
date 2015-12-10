class BankCardDetailsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @bank_card_detail = BankCardDetail.new
  end

  def create
    @bank_card_detail = BankCardDetail.new(bank_card_details_params)
    @bank_card_detail.user = current_user
    @valid_rec = false
    @valid_rec = true if @bank_card_detail.save
  end

  def edit
    @bank_card_detail = BankCardDetail.find(params[:id])
  end

  def update
    @bank_card_detail = BankCardDetail.find(params[:id])
    @bank_card_detail.attributes = bank_card_details_params
    @valid_rec = false
    @valid_rec = true if @bank_card_detail.save
  end

private

  def bank_card_details_params
    params.require(:bank_card_detail).permit(:first_name, :last_name, :email, :phone_number, :date_of_birth, :street_address,:locality,:region,:postal_code,:funding_email,:funding_phone_number,:funding_account_number,:funding_routing_number,:funding_routing_number_confirmation, :bank_ss_number)
  end
end