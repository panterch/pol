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
function galleryShowEntry(id)
{
  $$('.gallery-view-image').each( function(comp) {
    comp.hide();
  });
  $('gallery-view-image-' + id).show();
}

