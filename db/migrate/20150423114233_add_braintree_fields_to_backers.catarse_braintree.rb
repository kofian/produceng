# This migration comes from catarse_braintree (originally 20140731103558)
class AddBraintreeFieldsToBackers < ActiveRecord::Migration
  def change
    add_column :contributions, :bt_customer_token, :string
    add_index :contributions, :bt_customer_token
  end
end
