require 'test_helper'

class CompImageTest < ActiveSupport::TestCase


  def test_sti
    page = Factory(:page)
    img = page.comps.build
    img.type = 'CompImage'
    img.save!
    # this does _not_ work
    # assert img.reload.is_a?(CompImage), img.class.name
    assert page.comps(true).last.is_a?(CompImage), img.class.name
  end
  

end
