# this controller renders the pages for public access.
#
# to ease overwrtiting this controllers functionality, this is just a
# 'marker-class'. You may write your own custom pol_controller just by placing
# a file pol_controller.rb in your applications controllers directory.
#
class PolController < PolBaseController
  RAILS_DEFAULT_LOGGER.info('plugin pol_controller: completed class loading')
end
