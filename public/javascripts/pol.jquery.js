jQuery.noConflict();
jQuery(document).ready(function(){
  // make input fields for pages bigger when needed
  jQuery('#comp_content').removeAttr('cols').removeAttr('rows').css({'min-height':300}).elastic();
  
  // init tree view
  jQuery('#tree_page').treeview({
    collapsed: true
  });
  // show active tree element and the according parents
  jQuery('#tree_page .active').parentsUntil('#tree').children('.hitarea').click();
  
  // make tree elements sortable
  jQuery('#sort_pages').click(function(){
    if(jQuery(this).hasClass('sort')){
      jQuery(this).removeClass('sort').text('Seiten sortieren');
      jQuery('#tree_page ul').css({'cursor':'default'});
      jQuery('#tree_page ul').each(function(){
        var id = jQuery(this).attr('id').replace('tree_page_', '');
        var attributes = {no_rjs : true};
        var pages = jQuery(this).sortable('toArray').map(function(e){return e.replace('tree_page_', '')});
        attributes['pages_' + id] = pages;
        jQuery.post('/pages/' + id + '/order', attributes, function(){});
        jQuery(this).sortable('destroy');
      });
    }else{
      jQuery(this).addClass('sort').text('Sortierung speichern');
      jQuery('#tree_page ul').css({'cursor':'row-resize'}).sortable();
    }
  });
});