class BankCardDetail < ActiveRecord::Base
	include BraintreePayment
	belongs_to :user

	STATUSES = {
		:pending => 0,
		:active => 1,
		:suspended => 2
	}

	attr_accessor :funding_routing_number_confirmation

	validates :first_name,presence: true
	validates :last_name,presence: true
	validates :email,presence: true
	validates_format_of :email, with: Devise.email_regexp, allow_blank: true
	validates :phone_number,presence: true
	validates :date_of_birth,presence: true
	validates :bank_ss_number, numericality: { only_integer: true,allow_blank: true },length: { is: 9,allow_blank: true },presence: true
	validates :street_address,presence: true
	validates :locality,presence: true
	validates :region,presence: true

	validates :funding_email,presence: true
	validates_format_of :funding_email, with: Devise.email_regexp, allow_blank: true
	validates :funding_phone_number,presence: true
	validates :funding_account_number,presence: true,uniqueness: true, numericality: { only_integer: true, allow_blank: true }
	validates :funding_routing_number,presence: true,uniqueness: true, numericality: { only_integer: true, allow_blank: true },confirmation: true

	scope :active, -> { where('status = ?',STATUSES[:active]) }

	# validates :card_number, numericality: { only_integer: true, allow_blank: true }
	# validates :card_cvv, numericality: { only_integer: true,allow_blank: true }
	# validates_format_of :dwolla_email_address, with: Devise.email_regexp, allow_blank: true, if: :dwolla_email_address_changed?
	# validates_format_of :paypal_email_address, with: Devise.email_regexp, allow_blank: true, if: :paypal_email_address_changed?
	# validates_format_of :receiving_dwolla_email_address, with: Devise.email_regexp, allow_blank: true, if: :receiving_dwolla_email_address_changed?
	# validates_format_of :receiving_paypal_email_address, with: Devise.email_regexp, allow_blank: true, if: :receiving_paypal_email_address_changed?
  #
	# validates :bank_routing_number, numericality: { only_integer: true, allow_blank: true }
	# validates :checking_account_number, numericality: { only_integer: true,allow_blank: true },confirmation: true
	# validates :bank_ss_number, numericality: { only_integer: true,allow_blank: true },length: { is: 4,allow_blank: true }
	# validates_length_of :bank_ss_number, :is => 9, numericality: { only_integer: true,allow_blank: true }
  # Dummy data here please delete if necessary
  # attr_accessor :first_name, :last_name, :email, :phone_number, :date_of_birth, :street_address, :locality, :region, :postal_code, :funding_email,
  #               :funding_mobile_number, :funding_account_number, :funding_routing_number, :funding_verify_routing


	before_save :create_update_remote

	def full_name
		"#{self.first_name} #{self.last_name}"
	end

	def show_mask_account_number
		mask(self.funding_account_number)
	end

	def show_status
		return STATUSES.key(self.status).to_s.titleize
	end
private

	def last_digits(number)
		number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
	end

	def mask(number)
		"XXXX-XXXX-XXXX-#{last_digits(number)}"
	end

	def create_update_remote
		api_params = Hash.new
		api_params[:individual] = {
			:first_name => self.first_name,
			:last_name => self.last_name,
			:email => self.email,
			:phone => self.phone_number,
			:date_of_birth => self.date_of_birth,
			:ssn => self.bank_ss_number,
			:address => {
				:street_address => self.street_address,
				:locality => self.locality,
				:region => self.region,
				:postal_code => self.postal_code
			}
		}
		api_params[:funding] = {
			:destination => Braintree::MerchantAccount::FundingDestination::Bank,
			:email => self.funding_email,
			:mobile_phone => self.funding_phone_number,
			:account_number => self.funding_account_number,
			:routing_number => self.funding_routing_number
		}

		api_params[:braintree_id] = self.remote_id if self.remote_id.present?
		response_obj = create_update_sub_merchant(api_params)

		if response_obj.success?
			braintree_id = response_obj.merchant_account.id
			self.remote_id = braintree_id if self.remote_id.nil?

			merchant_account = Braintree::MerchantAccount.find(braintree_id)

			self.status = STATUSES[merchant_account.status.to_sym]
			return true
		else
			self.errors.add(:base,response_obj.errors.first.message)
			return false
		end

	end
end
