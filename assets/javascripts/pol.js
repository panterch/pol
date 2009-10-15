function register_video(id) {
  flowplayer(id, "/flowplayer-3.1.1.swf", { 
    clip: { 
        autoPlay: true, 
        autoBuffering: true }
  });
}

// gallery navigation
function galleryShowEntry(id)
{
  $$('.gallery-view-image').each( function(comp) {
    comp.hide();
  });
  $('gallery-view-image-' + id).show();
}

function onHomepage() {
  var path = window.location.pathname;
  return '/' == path || '/index' == path;
}

// image preloading
Event.observe(window, 'load', function() {
  // first fix src attribute
  $$('img.preload').each(function(img) { img.src = img.readAttribute('preload'); });
  // then cache images
  if (document.images) {
    $$('img.preload').each(function(img) { new Image().src = img.src; });
  }
});

// wake up passenger even for cached pages
Event.observe(window, 'load', function() {
  if (onHomepage()) {
    // this is really low prio - give other scripts a chance to execute before
    setTimeout("new Ajax.Request('/ls-R', { method: 'get' })", 1000);
  }
});

