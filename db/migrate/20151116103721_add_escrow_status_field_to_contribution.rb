class AddEscrowStatusFieldToContribution < ActiveRecord::Migration
  def change
    add_column :contributions, :escrow_status, :string
  end
end
