App.addChild('BraintreeForm', _.extend({
  el: '#catarse_braintree_form',

  events: {
    'click input[type=submit]': 'onSubmitToBraintree',
    'keyup #user_document' : 'onUserDocumentKeyup'
  },

  initialize: function() {
    this.loader = $('.loader');
  },

  onSubmitToBraintree: function(e) {
    $(e.currentTarget).hide();
    this.loader.show();
  }
}, window.Braintree.UserDocument));

