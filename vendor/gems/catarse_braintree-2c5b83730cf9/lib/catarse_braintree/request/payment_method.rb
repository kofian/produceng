module CatarseBraintree
  module Request

    class PaymentMethod < CatarseBraintree::Request::Base
      FORM_INPUTS = [
        :first_name,
        :last_name,
        :company,
        :email,
        :phone,
        :fax
      ]

      ADDRESS_INPUTS = [
        :street_address,
        :extended_address,
        :locality,
        :region,
        :postal_code
      ]

      TEST_VALS = {
        first_name: 'Matt',
        last_name: 'Test',
        company: 'Codebeef',
        email: 'matt@codebeef.com',
        phone: '01613037321',
        fax: ''
      }

      TEST_ADDRESS_VALS = {
        street_address:   'Holly Cottage',
        extended_address: 'Chester Road',
        locality:         'Tarporley',
        postal_code:      'CW6 9JE',
        region:           'Cheshire'
      }

      def nonce
        options[:payment_method_nonce]
      end

      def address_options
        ADDRESS_INPUTS.inject({}) do |data, key|
          data[key] = options[key]
          data
        end
      end

      def customer_options
        FORM_INPUTS.inject({}) do |data, key|
          data[key] = options[key]
          data
        end.merge({
          payment_method_nonce: nonce
        })
      end

      def create_customer
        @response = Braintree::Customer.create(customer_options)
        @customer = @response.customer if @response.success?
        @response
      end

      def customer
        @customer ||= create_customer.customer
      end

      def result
        response = create_customer

        Rails.logger.debug response.inspect

        if response.success?
          address = customer.addresses.first

          contribution.update_attributes({
            payment_method: 'Braintree',
            bt_customer_token: customer.id
          })

          if address
            contribution.update_attributes({
              address_street: address.street_address,
              address_zip_code: address.postal_code,
              address_city: address.locality,
              address_state: address.region,
              address_phone_number: customer.phone,
            })
          end

          contribution.confirm!
        end

        response
      end
    end

  end
end


