class AddBraintreeStatusFieldToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :braintree_status, :integer
  end
end
