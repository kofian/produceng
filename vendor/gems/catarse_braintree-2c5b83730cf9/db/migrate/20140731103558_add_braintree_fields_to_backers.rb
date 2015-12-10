class AddBraintreeFieldsToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :bt_customer_token, :string
    add_index :backers, :bt_customer_token
  end
end
