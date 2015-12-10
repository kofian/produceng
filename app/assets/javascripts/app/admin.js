App.addChild('Admin', {
  el: '.admin',

  events: {
    'click .project-admin-menu' : "toggleAdminMenu",
    'click .toggle-filters': 'toggleFilters',
  },

  toggleAdminMenu: function(event){
    var link = $(event.target);
    this.$dropdown = link.parent().next('nav');
    $('w--open').not(this.$dropdown).removeClass('w--open');
    this.$dropdown.toggleClass('w--open');
    return false;
  },

  toggleFilters: function(event) {
    var btn = $(event.target);
    btn.toggleClass('more');
    if (btn.text() == btn.data('more')) {
      btn.text(btn.data('less'));
    } else {
      btn.text(btn.data('more'));
    }
    $('.more-filters').slideToggle();
    event.preventDefault();
  }
});
