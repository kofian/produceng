App.addChild('Contribution', {
  el: '#new-contribution',

  events: {
    'click .radio label' : 'clickReward',
    'click #submit' : 'submitForm',
    'input #contribution_value' : 'restrictChars',
    'input .produce-qty': 'updateQty'
  },

  updateQty: function(e) {
    return this.updateTotalText( $(e.target).val() * this.minimumValue() );
  },

  updateTotalText: function(amount) {
     if (isNaN(amount)){
          amount = 0
     }
    if (amount>9999) {
      var tAmount = this.abbreviateAmt(amount.toFixed(2),2);
      this.$value_text.text(tAmount);
    } else {
      this.$value_text.text(amount.toFixed(2));
    }
  },

  restrictChars: function(event){
    var $target = $(event.target);
    $target.val($target.val().replace(/[^\d,]/, ''));
  },

  submitForm: function(){
    this.$('form').submit();
    return false;
  },

  activate: function(){
    this.$value = this.$('#contribution_value');
    this.$value_text = this.$('#contribution_value_text');
    this.$minimum = this.$('#minimum-value');
    this.clickReward({currentTarget: this.$('input:checked').parent()[0]});
    console.log(this);
  },

  resetReward: function(event){
    if(parseInt('0' + this.$value.val()) < this.minimumValue()){
      this.selectReward(this.$('.radio label'));
    }
  },

  minimumValue: function(){
    return this.$('.selected').find('label[data-minimum-value]').data('minimum-value');
  },

  resetSelected: function(){
    this.$('.w-radio').removeClass('selected');
  },

  selectReward: function(reward){
    this.resetSelected();
    reward.find('input[type=radio]').prop('checked', true);
    reward.parent().addClass('selected');
  },

  clickReward: function(event){
    this.selectReward($(event.currentTarget));
    var minimum = this.minimumValue();
    var qty = $(event.currentTarget).find('.produce-qty').val();
    this.updateTotalText(minimum * qty);
    this.$value.val(minimum * $(event.currentTarget).find('.produce-qty').val());
    this.$minimum.html(minimum);
  },

  abbreviateAmt: function(number, decPlaces) {
    // 2 decimal places => 100, 3 => 1000, etc
    decPlaces = Math.pow(10,decPlaces);

    // Enumerate number abbreviations
    var abbrev = [ "k", "m", "b", "t" ];

    // Go through the array backwards, so we do the largest first
    for (var i=abbrev.length-1; i>=0; i--) {

      // Convert array index to "1000", "1000000", etc
      var size = Math.pow(10,(i+1)*3);

      // If the number is bigger or equal do the abbreviation
      if(size <= number) {
        // Here, we multiply by decPlaces, round, and then divide by decPlaces.
        // This gives us nice rounding to a particular decimal place.
        number = Math.round(number*decPlaces/size)/decPlaces;

        // Handle special case where we round up to the next abbreviation
        if((number == 1000) && (i < abbrev.length - 1)) {
          number = 1;
          i++;
        }

        // Add the letter for the abbreviation
        number += abbrev[i];

        // We are done... stop
        break;
      }
    }

    return number;
  }
});

App.addChild('FaqBox', {
  el: '#faq-box',

  events: {
    'click li.list-question' : 'clickQuestion'
  },

  clickQuestion: function(event){
    var $question = $(event.currentTarget);
    var $answer = $question.next();
    $question.toggleClass('open').toggleClass('alt-link');
    $answer.slideToggle('slow');
  },

  activate: function(){
    this.$('li.list-answer').hide();
  }
});
