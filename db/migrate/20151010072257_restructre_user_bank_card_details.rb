class RestructreUserBankCardDetails < ActiveRecord::Migration
  def change
    remove_column :bank_card_details,:card_holder_name,:string
    remove_column :bank_card_details,:card_number,:string
    remove_column :bank_card_details,:card_cvv,:string
    remove_column :bank_card_details,:card_expire_month,:integer
    remove_column :bank_card_details,:card_expire_year,:integer
    remove_column :bank_card_details,:dwolla_email_address,:string
    remove_column :bank_card_details,:paypal_email_address,:string
    remove_column :bank_card_details,:receiving_dwolla_email_address,:string
    remove_column :bank_card_details,:receiving_paypal_email_address,:string
    remove_column :bank_card_details,:zip_code,:string
    remove_column :bank_card_details,:bank_routing_number,:string
    remove_column :bank_card_details,:checking_account_number,:string
    remove_column :bank_card_details,:account_holder,:string
    remove_column :bank_card_details,:bank_dob,:date
    remove_column :bank_card_details,:bank_ss_number,:string
    remove_column :bank_card_details,:street_address,:string
    remove_column :bank_card_details,:state,:string
    remove_column :bank_card_details,:card_zip_code,:string
    remove_column :bank_card_details,:phone_number,:string


    add_column :bank_card_details,:first_name,:string
    add_column :bank_card_details,:last_name,:string
    add_column :bank_card_details,:email,:string
    add_column :bank_card_details,:phone_number,:string
    add_column :bank_card_details,:date_of_birth,:date

    add_column :bank_card_details,:street_address,:string
    add_column :bank_card_details,:locality,:string
    add_column :bank_card_details,:region,:string
    add_column :bank_card_details,:postal_code,:string

    add_column :bank_card_details,:funding_email,:string
    add_column :bank_card_details,:funding_phone_number,:string
    add_column :bank_card_details,:funding_account_number,:string
    add_column :bank_card_details,:funding_routing_number,:string
    add_column :bank_card_details,:remote_id,:string, foreign_key: false
    add_column :bank_card_details,:status,:integer,:default => 0

  end
end
