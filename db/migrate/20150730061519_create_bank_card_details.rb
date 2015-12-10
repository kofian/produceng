class CreateBankCardDetails < ActiveRecord::Migration
  def change
    create_table :bank_card_details do |t|
    	t.integer :user_id
    	t.string :card_holder_name
    	t.integer :card_number,:limit => 6
    	t.string :card_cvv
    	t.integer :card_expire_month
    	t.integer :card_expire_year
    	t.string :zip_code
    	t.string :dwolla_email_address
    	t.string :paypal_email_address
    	t.string :receiving_dwolla_email_address
    	t.string :receiving_paypal_email_address
    	t.string :bank_routing_number
    	t.string :checking_account_number    	
    	t.string :account_holder
    	t.date :bank_dob
    	t.integer :bank_ss_number
    	t.string :street_address
    	t.string :state
    	t.string :card_zip_code
    	t.string :phone_number
      t.timestamps
    end
  end
end