require File.dirname(__FILE__) + '/../test_helper'

class CompsControllerTest < ActionController::TestCase

  def test_render_show
    Page.delete_all
    Comp.delete_all
    page = Factory(:page)
    comp = Factory(:comp_text, :page => page)
    assert_render :show, :id => comp.id, :page_id => page.id
    assert_instance_of CompText, assigns(:comp)
  end

  def test_render_edit
    Page.delete_all
    Comp.delete_all
    page = Factory(:page)
    comp = Factory(:comp_text, :page => page)
    assert_render :edit, :id => comp.id, :page_id => page.id
  end

  def test_render_new_comp_image
    Page.delete_all
    Comp.delete_all
    page = Factory(:page)
    comp = Factory(:comp_image, :page => page)
    assert_render :new, :page_id => page.id, :type => CompImage.name
  end

  def test_render_new_comp_text
    Page.delete_all
    Comp.delete_all
    page = Factory(:page)
    comp = Factory(:comp_text, :page => page)
    assert_render :new, :page_id => page.id, :type => CompText.name
  end

  def test_render_new_comp_video
    Page.delete_all
    Comp.delete_all
    page = Factory(:page)
    comp = Factory(:comp_video, :page => page)
    assert_render :new, :page_id => page.id, :type => CompVideo.name
  end
  
  def test_render_new_comp_map
    Page.delete_all
    Comp.delete_all
    page = Factory(:page)
    comp = Factory(:comp_map, :page => page)
    assert_render :new, :page_id => page.id, :type => CompMap.name
  end
  
  def test_create_image
    page = Factory(:page)
    assert_difference 'Comp.count'  do
      post :create, :page_id => page.id, :comp =>
           { :content => 'test content', :type => 'CompImage', :media =>
             fixture_file_upload('/files/kitten.jpg', 'image/jpg')}
      assert_response :redirect
    end
    assert_equal 'test content', Comp.last.content
    assert_equal page, Comp.last.page
    assert Comp.last.is_a?(CompImage), Comp.last.class.name
  end

  # Disabled since CompText does not contain a validation. Creation succeeds and tests fails.
  def disabled_test_create_validation_text
    page = Factory(:page)
    assert_no_difference 'Comp.count'  do
      post :create, :page_id => page.id, :comp => {:type => 'CompText'}
      assert_response :success
    end
    assert !assigns(:comp).errors.empty?
  end
  
  def test_update_text
    page = Factory(:page)
    comp = Factory(:comp_text, :page => page)
    assert_no_difference 'Comp.count'  do
      put :update, :page_id => page.id, :id => comp.id,
           :comp => { :content => 'test update' }
      assert_response :redirect
    end
    assert_equal 'test update', comp.reload.content
  end

  def test_update_validate_image
    page = Factory(:page)
    comp = Factory(:comp_image, :page => page)
    put :update, :page_id => page.id, :id => comp.id,
        :comp => { :type => 'CompImage', :media =>
                 fixture_file_upload('/files/video.flv', 'video/x-flv')}
    assert_response :success
    assert !assigns(:comp).errors.empty?
  end

  def test_upload_video
    page = Factory(:page)
    assert_difference 'CompVideo.count' do
      post :create, :page_id => page.id, 
           :comp => { :type => 'CompVideo', :media =>
                      fixture_file_upload('/files/video.flv', 'video/x-flv')}
      assert_response :redirect
    end
    assert File.exist? CompVideo.last.media.path(:normal)
    assert File.exist? CompVideo.last.media.path
  end if TEST_FFMPEG


  def test_type_param
    page = Factory(:page)
    get :new, :type => 'CompImage', :page_id => page.id
    assert_response :success
    assert assigns(:comp).is_a?(CompImage), assigns(:comp).class.name
    assert_equal page, assigns(:comp).page
  end
  
  

  def test_create_map
    page = Factory(:page)
    assert_difference 'CompMap.count' do
      post :create, :page_id => page.id,
           :comp => {:type => 'CompMap', :lat => 46.3434223, :lng => 8.3434,
                      :level => 14 }
      assert_response :redirect
    end
    assert Comp.last.is_a? CompMap
    assert 14, Comp.last.level
    assert 8.3434, Comp.last.level
  end
  
  
  def test_update_lat_lng
    page = Factory(:page)
    comp = Factory(:comp_map, :page => page)
    put :update, :page_id => page.id, :id => comp.id, 
                          :comp => { :lat => 56.445, :lng => 6.789}
    assert 56.445, comp.lat
    assert 6.789, comp.lng
  end
  
end
