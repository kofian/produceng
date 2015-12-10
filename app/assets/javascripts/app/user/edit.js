App.addChild('UserEdit', _.extend({
  el: '.user-dashboard-edit',

  events:{
    "click #toggle-notifications": "toggleNotifications",
    "click #payment_receiving_banks": "showReceivingListBank",
    "click #btn_receiving_add_bank": "showReceivingAddBank",
    "click #btn_receiving_edit_bank": "showReceivingEditBank",
    "click #btn_receiving_remove_bank": "showReceivingRemoveBank"
  },

  activate: function(){
    var that = this;

    this.route('contributions');
    this.route('projects');
    this.route('about_me');
    this.route('settings');
    this.route('billing');
    this.route('notifications');
    this.route('feeds');

    this.lookAnchors();
    this.ajax_start_stop();

    $('.receiving_bank_details').hide();
    $('#receiving_banks_list').show();
    $('#receiving_banks').show();
  },

  toggleNotifications: function(){
    event.preventDefault();
    this.$('#notifications-box').toggle();
  },

  followRoute: function(name){
    var $tab = this.$('nav a[href="' + window.location.hash + '"]');
    if($tab.length > 0){
      this.onTabClick({ currentTarget: $tab });
    }
  },

  loadEmbed: function() {
    var that = this;

    if(this.$embed.find('.loader').length > 0) {
      $.get(this.$embed.data('path')).success(function(data){
        that.$embed.html(data);
      });
    }
  },


  showReceivingListBank: function(){
    $('#receiving_banks_list').show();
    $('#receiving_bank_form').hide();
  },

  showReceivingAddBank: function(){
    $.ajax({
      url: '/bank_card_details/new',
      type: 'GET'
    })
  },

  showReceivingEditBank: function(){
    var val = $('input[name=bank_card_detail]:checked').val();
    if(val != undefined){
      //$.msg({ clickUnblock : false, autoUnblock:false });
      $.ajax({
        url: '/bank_card_details/' + val + '/edit',
        type: 'GET'
      });
    }
    else{
      alert ('Please select one card detail');
    }
  },
  showReceivingRemoveBank: function(){
    var val = $('input[name=bank_card_detail]:checked').val();
    if(val != undefined){
      $.ajax({
        url: '/bank_card_details/' + val + '/edit',
        type: 'DELETE'
      });
    }
    else{
      alert ('Please select one card detail');
    }
  },
  ajax_start_stop: function(){
    $(document).ajaxStart(function () {
      timer = setTimeout(function () {
        $.msg({clickUnblock: false, autoUnblock: false});
      }, 250);
    });

    $(document).ajaxStop(function () {
      $.msg('unblock');
      clearTimeout(timer);
    });
  }

}, Skull.Tabs));