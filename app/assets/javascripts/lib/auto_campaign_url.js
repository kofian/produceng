$(document).ready(function() {
	set_slug();
});

// sets the slug on the key change of group name
function set_slug(){
  $('#project_name').on("keyup",function() {
    name = $('#project_name').val();
		url = name.replace(/([^a-z0-9]+)/gi, '-').toLowerCase();
		$('#project_permalink').val(url);
  });
}
