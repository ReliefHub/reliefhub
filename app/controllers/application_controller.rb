class ApplicationController < ActionController::Base
  protect_from_forgery
  include ERB::Util

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || request.compatible_language_from(['en', 'fr'])
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  def sign_up_path
    new_user_registration_path
  end
  helper_method :sign_up_path

  def sign_in_path
    new_user_session_path
  end
  helper_method :sign_in_path

  def sign_out_path
    destroy_user_session_path
  end
  helper_method :sign_out_path

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to page_path(current_user.nil? ? 'access_denied_anonymous' : 'access_denied')
  end

end
