class ChangeBankIdConstraint < ActiveRecord::Migration
  def change
    change_column :bank_accounts, :bank_id, :integer, :null => true
    
  end
end
