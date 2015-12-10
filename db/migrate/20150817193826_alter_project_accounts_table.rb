class AlterProjectAccountsTable < ActiveRecord::Migration
  def change
    remove_column :project_accounts,:bank_id
    remove_column :project_accounts,:agency
    remove_column :project_accounts,:agency_digit
    remove_column :project_accounts,:account
    remove_column :project_accounts,:account_digit
    remove_column :project_accounts,:owner_name
    remove_column :project_accounts,:owner_document
    remove_column :project_accounts,:account_type

    add_column :project_accounts,:bank_routing_number,:string
    add_column :project_accounts,:checking_account_number,:string
    add_column :project_accounts,:account_holder,:string
    add_column :project_accounts,:bank_dob,:date
    add_column :project_accounts,:bank_ss_number,:integer
    add_column :project_accounts,:street_address,:string
    add_column :project_accounts,:state,:string
    add_column :project_accounts,:zip_code,:string
    add_column :project_accounts,:bank_phone_number,:string
  end
end
