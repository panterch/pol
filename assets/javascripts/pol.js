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
  var path = window.location.pathname;
  if ('/' == path || '/index' == path) {
    new Ajax.Request('/ls-R', { method: 'get' });
  }
});

