require 'RedCloth'
require 'video_thumbnail'
require 'pol_config'

ActionView::Helpers::AssetTagHelper.register_javascript_include_default 'pol'

# do reload with each request in development mode
if 'development' == RAILS_ENV
  ActiveSupport::Dependencies.load_once_paths.reject! do |path|
    path.match File.dirname(__FILE__)
  end
  RAILS_DEFAULT_LOGGER.warn("adapted load_once_paths #{ActiveSupport::Dependencies.load_once_paths}")
end

