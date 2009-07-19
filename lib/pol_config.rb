class PolConfig
  include Singleton

  attr_accessor :comp_locations, :comp_available, :version

  def initialize
    @version = '2009'

    # this defines the style classes and which components are available in them
    @comp_locations = [ 'left-box', 'right-box' ]
    @comp_available = {
      'top-box' => [ ],
      'bottom-box' => [ ],
      'left-box' => [ CompText, CompImage, CompVideo ],
      'right-box' => [ CompText, CompImage, CompGallery ]
    }
  end

end

# shortcut to the configuration
def pol_cfg()
  PolConfig.instance
end
