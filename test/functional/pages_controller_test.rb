require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  def test_render
    page = Factory(:page)
    get :index
    assert_response :redirect
  end

  def test_render_show
    page = Factory(:page)
    assert_render :show, :id => page.id
  end

  def test_render_edit
    page = Factory(:page)
    assert_render :edit, :id => page.id
  end

  def test_create
    page = Factory(:page)
    assert_difference 'Page.count'  do
      post :create, :page_id => page,
           :page => { :title => 'test_create', :icon => 
                      fixture_file_upload('/files/kitten.jpg', 'image/jpg')}
      assert_response :redirect
    end
    assert Page.last.icon.file?
    assert_match 'kitten', Page.last.icon.url
    assert_equal page, Page.last.parent
    assert_not_equal '', Page.last.permalink
  end

  def test_destroy
    Page.delete_all
    Comp.delete_all
    page = Factory(:page, :title => "Home")
    post :destroy, :id => page
    assert_equal 0, Page.count # impress & contact stay
    assert_equal 0, Comp.count
  end

  def test_order_children
    page_root = Factory(:page)
    page_child_a = Factory(:page, :parent => page_root)
    page_child_b = Factory(:page, :parent => page_root)
    page_child_c = Factory(:page, :parent => page_root)
    post :order, :id => page_root,
                 page_root.id.to_s => page_root.children.map(&:id).reverse
    assert_response :success
    assert_equal page_child_c, page_root.children(true)[0]
    assert_equal page_child_b, page_root.children[1]
    assert_equal page_child_a, page_root.children[2]
  end

end
