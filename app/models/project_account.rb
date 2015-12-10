class ProjectAccount < ActiveRecord::Base
  belongs_to :project
  belongs_to :bank

  attr_accessor :checking_account_number_confirmation
end
