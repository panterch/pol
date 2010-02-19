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
  if ("undefined" == typeof(tinyMCE)) {
    return;
  }
  tinyMCE.init({
    mode : "specific_textareas",
    theme : "advanced",
    editor_selector : "richtext",
    content_css : "/stylesheets/application.css",
    body_class : "comp",
    
    plugins : "safari,spellchecker,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras",

    // Theme options
    theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,styleselect,formatselect,fontselect,fontsizeselect",
    theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,help,code,|,insertdate,inserttime,preview,|,forecolor,backcolor",
    theme_advanced_buttons3 : "tablecontrols,|,hr,removeformat,visualaid,|,sub,sup,|,charmap,emotions,iespell,media,advhr,|,print,|,ltr,rtl,|,fullscreen",
    theme_advanced_buttons4 : "insertlayer,moveforward,movebackward,absolute,|,styleprops,spellchecker,|,cite,abbr,acronym,del,ins,attribs,|,visualchars,nonbreaking,template,blockquote,pagebreak,|,insertfile,insertimage",
    theme_advanced_statusbar_location : "bottom",
    theme_advanced_resizing : true,
    removeformat_selector : 'p,b,strong,em,i,span,ins',
    table_inline_editing : true,
    external_image_list_url : "/ls-R.js?mode=external_image_list"
  });
}

Event.observe(window, 'load', function() {
  initRichEditors();
});
