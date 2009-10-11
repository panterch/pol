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
  if (document.images) {
    $$('img.preload').each(function(img) {
      img.src = img.readAttribute('preload');
      new Image().src = img.src;
      
    });
  }
});
