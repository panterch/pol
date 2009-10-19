var wake_up = null;

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

function wake_up_passenger() {
  new Ajax.Request('/ls-R', { method: 'get' });
}

function registerLiveValidation() {
  $$('.lv').each(function(elem) {
    var lv = new LiveValidation(elem, { onlyOnBlur: true });
    if (elem.hasClassName('presence')) {
      lv.add(Validate.Presence, {failureMessage: "Muss ausgefüllt werden"});
    }
    if (elem.hasClassName('email')) {
      lv.add(Validate.Email, {failureMessage: "Keine gültige EMail Adresse"});
    }
  });
}

Event.observe(window, 'load', function() {
  registerLiveValidation();
  // wake up passenger even for cached pages
  if (onHomepage()) {
    // this is really low prio - give other scripts a chance to execute before
    wake_up = setTimeout(wake_up_passenger, 1000);
  }
});

