
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

function galleryShowEntry(id)
{
  $$('.gallery-view-image').each( function(comp) {
    comp.hide();
  });
  $('gallery-view-image-' + id).show();
}

