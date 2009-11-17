var wake_up = null;

function register_video(id) {
  flowplayer(id, "/flowplayer-3.1.1.swf", { 
    clip: { 
        autoPlay: true, 
        autoBuffering: true }
  });
}

function ie_x_or_higher(x) {
  // consider every other browser as 'higher'
  if (!Prototype.Browser.IE) return true;
  // check ie version
  var v = parseInt(navigator.userAgent.substring(navigator.userAgent.indexOf("MSIE")+5));
  return v >= x;
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

function getUrlParameter(name) {
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null ) {
    return null;
  } else {
    return results[1];
  }
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
function wake_up_passenger() {
  new Ajax.Request('/ls-R', { method: 'get' });
}

// register live validation javascripts for inputs w/ class lv
function registerLiveValidation() {
  $$('.lv').each(function(elem) {
    var lv = new LiveValidation(elem, { onlyOnBlur: true });
    if (elem.hasClassName('presence')) {
      lv.add(Validate.Presence, {failureMessage: "Dies ist ein Pfichtfeld - Danke für Ihre Eingabe"});
    }
    if (elem.hasClassName('email')) {
      lv.add(Validate.Email, {failureMessage: "Keine gültige EMail Adresse"});
    }
  });
}

// register target blank for links w/ rel=external
function registerNewWindowLinks() {
  $$('a[rel="external"]').each(function(link){
      if(link.readAttribute('href') != '' && link.readAttribute('href') != '#'){
          link.writeAttribute('target','_blank');
      }
  });
}

// depending on the url paramter, the mailer form or a success message is shown
function showMailerForm() {
  $$('form.mailer').each(function(elem) {
    var selector = window.location.href.match(/success/) ? '.success' : '.query';
    elem.getElementsBySelector(selector).each(function(to_show) {
      to_show.show();
      });
  });
}

Event.observe(window, 'load', function() {
  registerLiveValidation();
  registerNewWindowLinks();
  showMailerForm();

  if (onHomepage()) {
    // this is really low prio - give other scripts a chance to execute before
    wake_up = setTimeout(wake_up_passenger, 1000);
  }
});

