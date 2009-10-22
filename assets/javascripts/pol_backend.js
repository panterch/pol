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

function initRichEditors()
{
  tinyMCE.init({
    mode : "specific_textareas",
    theme : "advanced",
    editor_selector : "richtext",
    content_css : "/stylesheets/application.css",
    body_class : "content",
    theme_advanced_toolbar_location : "bottom",
    theme_advanced_toolbar_align : "left",
    plugins : "table",
    theme_advanced_buttons3_add : "tablecontrols",
    theme_advanced_buttons3_add_before : "tablecontrols,separator",
    theme_advanced_buttons4 : "",
    table_inline_editing : true
  });
}

Event.observe(window, 'load', function() {
  initRichEditors();
});