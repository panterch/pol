// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



Event.observe(window, 'load', function() {
  // seb this broke granat.panter.ch
	// loadMap();
	/*GEvent.addListener(window, 'init', function() {
    loadMap();
  })*/
});

function register_video(id) {
  // Event.observe(window, 'load', function() {
    flowplayer(id, "/flowplayer-3.1.1.swf", { 
      clip: { 
          autoPlay: true, 
          autoBuffering: true }
    });
  // });
}

// image preloading
function register_image(url) {
  if (document.images) {
    Event.observe(window, 'load', function() {
      new Image().src = url;
    });
  }
}



function replace_comp(hide, show) {
  $('comp_'+hide).hide();
  $('comp_'+show).show();
}


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

function galleryShowEntry(index)
{
  var images = $$('.gallery-view-image');
  for(var i = 0; i < images.length; i++)
  {
    $('gallery-view-image-' + i).hide();
    $('gallery-view-text-' + i).hide();
  }
  $('gallery-view-image-' + index).show();
  $('gallery-view-text-' + index).show();  
}