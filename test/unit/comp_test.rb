require 'test_helper'

class CompTest < ActiveSupport::TestCase

  def test_build_sti
    assert_instance_of CompImage, Comp.build_sti('CompImage')
    assert_raise SecurityError do
      Comp.build_sti('String')
    end
  end

  def test_position_scope
    Comp.delete_all
    Page.delete_all
    page = Factory(:page, :title => "Home")
    (1..5).each do |i|
      page.comps.create(:style_class => 'left-box', :content => i.to_s)
    end
    parent = page.comps_left.first
    assert_equal "1", parent.content
    (1..5).each do |i|
      c = parent.children.create(:style_class => 'left-box', :content => i.to_s,
                                 :page => page)
      assert_equal i, c.position
    end

  end
  
end
