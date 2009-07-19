require 'test_helper'

class PageTest < ActiveSupport::TestCase

  def setup
    Page.delete_all
    Comp.delete_all
    @h = Factory(:page, :title => "Home")
    @c1 = Factory(:page, :title => "Snow", :parent => @h)
    @c12 = Factory(:page, :title => "Snow Events", :parent => @c1)
    @c123a = Factory(:page, :title => "Snow Events Event A", :parent => @c12)
    @c123b = Factory(:page, :title => "Snow Events Event B", :parent => @c12)
    @c123c = Factory(:page, :title => "Snow Events Event C", :parent => @c12, 
                     :hidden => true)
  end

  def test_fixture
    assert @h
    assert_nil @h.parent_id
    assert_nil @h.parent

    assert_equal @h, @c1.parent
  end

  def test_acts_as_tree

    assert_difference "Page.count" do
      @h.children.create!(:title => 'tree title', :desc => 'desc')
    end
    assert_equal 'tree title', @h.reload.children.last.title
  end

  def test_ancestors
    assert 3, @c123a.ancestors.length
  end

  def test_ancestors_and_self
    assert 4, @c123a.ancestors_and_self.length
    assert_equal @h, @c123a.ancestors_and_self.first
    assert_equal @c12, @c12.ancestors_and_self.last
  end

  def test_dependent_destroy
    Page.root.destroy
    assert_equal 0, Page.count # impress & contact stay
    assert_equal 0, Comp.count
  end

  def test_order_children
    @c12.order_children([ @c123a.id,
                          @c123b.id,
                          @c123c.id ])
    assert_equal @c123a, @c12.children(true)[0]
    assert_equal @c123b, @c12.children[1]
    assert_equal @c123c, @c12.children[2]
  end

  def test_ancestor_titles
    assert_equal "", Page.root.ancestor_titles
    assert_equal "Snow", @c12.ancestor_titles
  end

  def test_permalink_overwrite
    p = @c1
    p.update_attributes(:permalink => 'test_permalink_overwrite')
    assert_equal 'test_permalink_overwrite', p.reload.permalink
  end

  def test_permalink_generation_when_empty
    p = @c1
    p.update_attributes(:permalink => '')
    assert_not_equal '', p.reload.permalink 
  end

  def test_permalink_uniqueness
    @c1.update_attributes(:permalink => 'unique')
    @c12.update_attributes(:permalink => 'unique')
    assert_not_equal @c1.reload.permalink,
                     @c12.reload.permalink
  end

  def test_nav_children
    assert_equal @h.children, @h.nav_children
    assert_equal @c12.children.length - 1,
                 @c12.nav_children.length
  end

  def test_subpages
    assert_equal [], @h.subpages
    assert_equal [ @c123c ],
                 @c12.subpages
  end

end
