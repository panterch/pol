class PolConfig
  include Singleton

  attr_accessor :languages, :version,
                :comp_locations, :comp_available, 
                :comp_image_styles, :password,
                :comp_gallery_control_style,
                :comp_gallery_view_style,
                :maps_api_key, :ga_api_key

  def initialize
    #
    # !!!! don't associate classes here that use pol_cfg in class context -
    # !!!! this will cause a deadlock
    #
    @languages = %w( de )
    @version = '2009'

    # this defines the style classes and which components are available in them
    @comp_locations = [ 'left-box', 'right-box' ]
    @comp_available = {
      'top-box' => [ ],
      'bottom-box' => [ ],
      'left-box' => %w( CompText CompImage CompVideo ),
      'right-box' => %w( CompText CompImage CompVideo )
    }

    # which thumbs to compute for images
    @comp_image_styles =  { :'top-box' => "740",
                           :'bottom-box' => "740",
                           :'left-box' => "490", 
                           :'right-box' => "240",
                           :'gallery-thumbnail' => "75",
                           :'lightbox-thumbnail' => "115x70#" }

    # where to render gallery control and view
    @comp_gallery_control_style = 'right-box'
    @comp_gallery_view_style    = 'left-box'

    # api keys
    @maps_api_key = ''
    @ga_api_key = nil

    # password for the admin interface
    @password = 'helvetia'
  end

end

# shortcut to the configuration
def pol_cfg()
  PolConfig.instance
end
