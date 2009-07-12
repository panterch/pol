var granat = function() {}

granat.maps = function() {
  var map = null;
  var markerManager = null;
  var markerListener = null;
  var createListener = null;
  var newMarker = null;
  var markers = {};
}

granat.maps.loadMap = function(canvas, editable) {
  if (GBrowserIsCompatible()) {
    var mapContainer = canvas;
    if(!mapContainer)
    {
      return;
    }
    this.map = new GMap2(mapContainer);
    var map = this.map;
    map.setMapType(G_HYBRID_MAP);
    var center;
    var level = 10;
    try
    {
      var lat = $('comp_lat').value;
      lat = lat != '' ? lat : 46.84422512910668;
      var lng = $('comp_lng').value;
      lng = lng != '' ? lng : 9.52789306640625;
      level = $('comp_level').value;
      level = level != '' ? level : 10;
      center = new GLatLng(lat, lng);
      map.setCenter(center, parseInt(level));
    }
    catch(e)
    {
      center = new GLatLng(46.84422512910668, 9.52789306640625);
      map.setCenter(center, parseInt(level));
    }
    if(editable)
    {
      map.setUIToDefault();
      granat.maps.updateLatLng(center);
      GEvent.addListener(map, "move", function(){
        granat.maps.updateLatLng(map.getCenter());
      });
      granat.maps.updateZoomLevel(map.getZoom());
      GEvent.addListener(map, "zoomend", function(){
        granat.maps.updateZoomLevel(map.getZoom());
      });
      this.createListener = GEvent.addListener(map, "click", function(ovl, latlng, ovllatlng){
        granat.maps.createSubComp(latlng, null, null);
      });
    }
    else
    {
      // map.disableDragging();
      var opts = new GMapUIOptions(new GSize(230, 400));
      // opts.maptypes.normal = false;
      opts.zoom.scrollwheel = true;
      opts.zoom.doubleclick = true;
      opts.zoom.keyboard = false;
      opts.controls.maptypecontrol = false;
      opts.controls.scalecontrol = true;
      map.setUI(opts);
    }
    
    this.markerManager = new GMarkerManager(map);
    
    var pageId = $('map_comp_page_id') ? $('map_comp_page_id').value : null;
    granat.maps.registerMarkers(pageId, editable);
    
  }
}

granat.maps.registerMarkers = function(pageId, edit)
{
  var markers = $('markers.register').value;
  if(!markers || markers == '')
  {
    return;
  }
  var markerCids = markers.split(',');
  for(var i = 0; i < markerCids.length; i++)
  {
    var cid = markerCids[i];
    var lat = $('marker.lat.' + cid).innerHTML;
    var lng = $('marker.lng.' + cid).innerHTML;
    var level = 0;
    if($('marker.level.' + cid))
    {
      var lv = $('marker.level.' + cid).innerHTML;
      level = parseInt("0" + lv.strip());
    }
    var latlng = new GLatLng(parseFloat(lat),  parseFloat(lng));
    granat.maps.createMarker(latlng, level, pageId, cid, edit);
  }
}

granat.maps.updateLatLng = function(latlng)
{
  $('comp_lat').value = latlng.lat();
  $('comp_lng').value = latlng.lng();
  $('coord_lat').update(latlng.lat());
  $('coord_lng').update(latlng.lng());
}
granat.maps.updateZoomLevel = function(zoom)
{
  $('comp_level').value = zoom;
  $('coord_level').update(zoom);
}

granat.maps.createSubComp = function(latlng, pageId, compId)
{
  if(this.newMarker)
  {
    this.newMarker.setLatLng(latlng);
  }
  var m = new GMarker(latlng, { boundcy: true, draggable: true, clickable: true});
  this.newMarker = m;
  this.markerManager.addMarker(m, 0);
  this.showCreateMenu(m, latlng);
}

granat.maps.showCreateMenu = function(m, latlng)
{
  var acts = $('mapaction').innerHTML;
  this.map.openInfoWindowHtml(latlng, acts, { maxWidth: 60 });
}

granat.maps.editSubComp = function(link)
{
  if(!this.newMarker)
  {
    return false;
  }
  var latlng = this.newMarker.getLatLng();
  var loc = link.href + "&lat=" + latlng.lat() + "&lng=" + latlng.lng() + 
    "&level=" + this.map.getZoom();
  document.location = loc;
  return false;
}


granat.maps.createMarker = function(latlng, level, pageId, compId, edit)
{
  this.map.closeInfoWindow();
  var m = new GMarker(latlng, { bouncy: true, draggable: edit, clickable: true });
  this.markerManager.addMarker(m, level);
  if(this.markerListener)
  {
    GEvent.removeListener(this.markerListener);
  }
  this.markerListener = null;
  if(edit)
  {
    GEvent.addListener(m, "dragend", function(latlng){
      granat.maps.saveMarkerPosition(latlng, pageId, compId);
    }); 
  }
  else
  {
    GEvent.addListener(m, "click", function(latlng) {
      granat.maps.showContentForMarker(compId);
    })
  }
}

granat.maps.saveMarkerPosition = function(latlng, pageId, compId)
{
  $('marker.lat.' + compId).innerHTML = latlng.lat();
  $('marker.lng.' + compId).innerHTML = latlng.lng();
  
  new Ajax.Request('/pages/' + pageId + '/comps/'+compId, 
                    { method: 'PUT', 
                    parameters: { "comp[lat]": latlng.lat(), "comp[lng]": latlng.lng() } });
}

granat.maps.showContentForMarker = function(compId)
{
  // load content for marker
  if(!$('comp_'+compId))
  {
     new Ajax.Request('/'+compId+'.js', { method: 'get', asynchronous: false } )
  }
  // hide all text-box
  var leftBoxes = $$('.left-box');
  var activated = $('comp_' + compId).ancestors()[0];
  for(var i = 0; i < leftBoxes.length; i++)
  {
    (activated == leftBoxes[i]) ? leftBoxes[i].show() : leftBoxes[i].hide();
  }
}

Event.observe(window, 'load', function() {
  var e = $('mapeditor') ? true : false;
  var canvas = e ? $('mapeditor') : $('mapviewer');
  granat.maps.loadMap(canvas, e);
});