class AddBraintreeMerchantIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects,:bank_card_detail_id,:integer
  end
end
