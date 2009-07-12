# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include ExceptionNotifiable

  before_filter :set_locale
  before_filter :authenticate

  helper_method :authenticated?

  protected

    def authenticate
      return true if 'test' == RAILS_ENV
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == I18n.t(:password)
      end
    end

    def authenticated?
      ActionController::HttpAuthentication::Basic.authorization(request)
    end
  
  

    def set_locale
      I18n.locale = :de
    end
end
