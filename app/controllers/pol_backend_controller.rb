class PolBackendController < ApplicationController
  include PolControl
  helper :pol
  layout 'pol_backend'

  before_filter :authenticate
  before_filter :set_locale
  helper_method :authenticated?

  protected

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

    # asserts that translation object for each language are present
    # this allows a nested form for all translations
    def globalize_object(model)
      pol_cfg.languages.each do |lang|
        next if model.globalize_translations.map(&:locale).include?(lang.to_sym)
        model.globalize_translations.build({ :locale => lang })
      end
    end
      
  
end
