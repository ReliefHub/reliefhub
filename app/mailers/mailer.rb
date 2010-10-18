class Mailer < ActionMailer::Base
  default :to => "info@reliefhub.org"

  def contact(sender, custom_body)
    @custom_body = custom_body
    mail :from => sender, :subject => "Contact us"
  end
end
