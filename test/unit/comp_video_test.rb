require 'test_helper'

class CompVideoTest < ActiveSupport::TestCase
  
  def test_ffmpeg
    assert !`which ffmpeg`.blank?, 'Could not find ffmpeg binary'
  end

  
end
