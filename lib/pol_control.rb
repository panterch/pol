# common methods of pol controllers
module PolControl

   def set_locale
    I18n.locale = session[:locale] if session[:locale]
    return unless params[:language]
    I18n.locale = session[:locale] = params[:language]
  end

end
