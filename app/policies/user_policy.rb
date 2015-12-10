class UserPolicy < ApplicationPolicy
  def destroy?
    done_by_owner_or_admin?
  end

  def credits?
    done_by_owner_or_admin?
  end

  def settings?
    done_by_owner_or_admin?
  end

  def edit?
    done_by_owner_or_admin?
  end

  def update?
    done_by_owner_or_admin?
  end

  def update_reminders?
    done_by_owner_or_admin?
  end

  def unsubscribe_notifications?
    done_by_owner_or_admin?
  end

  def permitted_attributes
    u_attrs = [:current_password, :password, bank_account_attributes: [:bank_id, :name, :agency, :account, :owner_name, :owner_document, :account_digit, :agency_digit] ]
    u_attrs << { category_follower_ids: [] }
    u_attrs << record.attribute_names.map(&:to_sym)
    u_attrs << { links_attributes: [:id, :_destroy, :link] }
    u_attrs << { category_followers_attributes: [:id, :user_id, :category_id] }
    u_attrs << { bank_card_detail_attributes: [:card_holder_name,:card_number,:card_cvv,:card_expire_month,:card_expire_year,:zip_code,:dwolla_email_address,:paypal_email_address,:receiving_dwolla_email_address,:receiving_paypal_email_address,:bank_routing_number,:checking_account_number,:account_holder,:bank_dob,:bank_ss_number,:street_address,:state,:card_zip_code,:phone_number,:checking_account_number_confirmation]}
    u_attrs.flatten!

    unless user.try(:admin?)
      u_attrs.delete(:zero_credits)
      u_attrs.delete(:permalink)
    end

    { user: u_attrs.flatten }
  end

  protected
  def done_by_owner_or_admin?
    record == user || user.try(:admin?)
  end
end

