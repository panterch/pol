require 'test_helper'

class PolControllerTest < ActionController::TestCase

  def test_show
    page = Factory(:page, :permalink => 'show-page')
    get :show, :permalink => page.permalink
    assert_response :success
    assert assigns(:page)
  end

  def test_index
    page = Factory(:page)
    get :index, :permalink => page.permalink
    assert_response :success
    assert_template 'pol/show.html.haml'
  end
  
  def test_show_level_2
    Page.delete_all
    page = Factory(:page)
    page_l2 = Factory(:page, :parent => page)
    page_l3 = Factory(:page, :parent => page_l2)
    get :show, :permalink => page_l2.permalink
    assert_response :success
    assert assigns(:subnav)
    assert_equal page_l2.children, assigns(:subnav)
    assert assigns(:icon_nav).blank?
  end

  def test_show_level_3
    Page.delete_all
    page = Factory(:page)
    page_l2 = Factory(:page, :parent => page)
    page_l3 = Factory(:page, :parent => page_l2)
    page_l4 = Factory(:page, :parent => page_l4)
    get :show, :permalink => page_l3.permalink
    assert_response :success
    assert_equal page_l3.self_and_siblings, assigns(:subnav)
    assert_equal page_l3.children, assigns(:relnav)
  end

  def test_show_level_4
    Page.delete_all
    page = Factory(:page)
    page_l2 = Factory(:page, :parent => page)
    page_l3 = Factory(:page, :parent => page_l2)
    page_l4 = Factory(:page, :parent => page_l3)
    get :show, :permalink => page_l4.permalink
    assert_response :success
    assert_equal page_l4.self_and_siblings, assigns(:relnav)
    assert_equal page_l4.nav_children, assigns(:icon_nav)
  end

  def test_404
    get :show, :permalink => 'non-existing-page'
    assert_response 404
  end

#  def test_cache
#    Page.delete_all
#    page = Factory(:page)
#    get :show, :permalink => page.permalink
#    cache = File.join(RAILS_ROOT, 'public/cache',
#                      page.permalink+'.html')
#    assert File.exist?(cache), 'File not found '+cache
#    page.update_attribute(:permalink, 'test_cache')
#    assert !File.exist?(cache), 'File not sweeped '+cache
#  end
#  
#  # single cache file must be deleted when any component of the page is changed
#  def test_comp_cache
#    Page.delete_all
#    page = Factory(:page)
#    comp = Factory(:comp_text, :page => page)
#    get :show, :permalink => page.permalink
#    cache = File.join(RAILS_ROOT, 'public/cache',
#                       page.permalink+'.html')
#    assert File.exist?(cache), 'File not found '+cache
#    comp.update_attribute(:content, 'comp_cache')
#    assert !File.exist?(cache), 'File not sweeped '+cache
#  end
#  
#  # cache file must remain when component of some other page is changed
#  def test_comp_cache_keepuntouched
#    Page.delete_all
#    page = Factory(:page)
#    page_other = Factory(:page)
#    comp = Factory(:comp_text, :page => page_other)
#    get :show, :permalink => page.permalink
#    cache = File.join(RAILS_ROOT, 'public/cache',
#                       page.permalink+'.html')
#    comp.update_attribute(:content, 'comp_cache')
#    assert File.exist?(cache), 'File sweeped unexpectedly; must remain '+cache
#  end
    
end
