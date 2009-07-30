class PolConfig
  include Singleton

  attr_accessor :maps_api_key, :comp_locations, :comp_available, :version,
                :comp_image_styles

  def initialize
    #
    # !!!! don't associate classes here that use pol_cfg in class context -
    # !!!! this will cause a deadlock
    #
    @version = '2009'

    # this defines the style classes and which components are available in them
    @comp_locations = [ 'left-box', 'right-box' ]
    @comp_available = {
      'top-box' => [ ],
      'bottom-box' => [ ],
      'left-box' => %w( CompText CompImage CompVideo ),
      'right-box' => %w( CompText CompImage CompVideo )
    }

    @comp_image_styles =  { :'top-box' => "740",
                           :'bottom-box' => "740",
                           :'left-box' => "490", 
                           :'right-box' => "240",
                           :'gallery-thumbnail' => "75",
                           :'lightbox-thumbnail' => "115x70#" }

    @maps_api_key = ''
  end

end

# shortcut to the configuration
def pol_cfg()
  PolConfig.instance
end
