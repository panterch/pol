// page editing (switch between content and attributes)
function edit_page_attribute() {
  $('page_form').show();
  $('page_content').hide();
  $('page_control_tab_attribute').className = 'control-tab-active';
  $('page_control_tab_content').className = 'control-tab';
  return false;
}

function edit_page_content() {
  $('page_form').hide();
  $('page_content').show();
  $('page_control_tab_attribute').className = 'control-tab';
  $('page_control_tab_content').className = 'control-tab-active';
  return false;
}
