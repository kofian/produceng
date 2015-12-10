App.addChild('ContributionPaymentForm', _.extend({
    el: 'form#contribution_payment_form',

    events: {
        'blur input' : 'checkInput',
        'change #contribution_address_state' : 'checkInput',
        'change #contribution_country_id' : 'onCountryChange',
        'change #contribution_anonymous' : 'toggleAnonymousConfirmation',
        'click #submit' : 'onSubmitClick'
    },

    onSubmitClick: function(){
        this.clearErrorBox();
        if(this.validate()){
            this.$errorMessage.hide();
        }
        else{
            this.$errorMessage.slideDown('slow');
            return false
        }
    },

    toggleAnonymousConfirmation: function(){
        this.$('#anonymous-confirmation').slideToggle('slow');
    },

    makeFieldsRequired: function(){
        this.$('[data-required-in-brazil]').prop('required', 'required');
        this.$('[data-required-in-brazil]').parent().removeClass('optional').addClass('required');
    },

    makeFieldsOptional: function(){
        this.$('[data-required-in-brazil]').prop('required', false);
        this.$('[data-required-in-brazil]').parent().removeClass('required').addClass('optional');
    },

    activate: function(){
        this.$errorMessage = this.$('#error-message');
        this.setupForm();
    },
    clearErrorBox: function(){
        $("#catarse_braintree_form_error").html('');
    }


}, Skull.Form));

/**
 * Created by brijesh on 30/7/15.
 */
