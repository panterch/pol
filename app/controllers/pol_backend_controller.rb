class PolBackendController < ApplicationController
  helper :pol
  layout 'pol_backend'

  before_filter :authenticate
  before_filter :set_locale
  helper_method :authenticated?

  protected

    def set_locale
      I18n.locale = session[:locale] if session[:locale]
      return unless params[:language]
      I18n.locale = session[:locale] = params[:language]
    end

    def authenticate
      return true if 'test' == RAILS_ENV
      return true if pol_cfg.password.blank?
      authenticate_or_request_with_http_basic do |username, password|
        username == "admin" && password == pol_cfg.password
      end
    end

    def authenticated?
      ActionController::HttpAuthentication::Basic.authorization(request)
    end
  
end
