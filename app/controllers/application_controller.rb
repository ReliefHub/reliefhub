class ApplicationController < ActionController::Base
  protect_from_forgery

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
end
