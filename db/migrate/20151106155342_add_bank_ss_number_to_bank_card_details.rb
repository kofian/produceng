class AddBankSsNumberToBankCardDetails < ActiveRecord::Migration
  def change
    add_column :bank_card_details, :bank_ss_number, :string
  end
end
