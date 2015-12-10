module BankCardDetailsHelper

  def get_bank_details
    @bank_card_details = current_user.bank_card_details
  end
end
