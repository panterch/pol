class PolMailer < ActionMailer::Base

  MAIL_RECIPIENT = 'pol@panter.ch'

  def contact(params)
    subject    "Kontaktanfrage"
    recipients MAIL_RECIPIENT
    from       params[:email]
     
    body       :contact => params
  end

  # a test method that can easily called from the console to test mailing, e.g.:
  # Mailer.deliver_test_mail foo@example.com
  def test_mail(to)
    subject 'pol test mail'
    recipients to
    from MAIL_RECIPIENT
    part "text/plain" do |p|
      p.body = 'pol ist tol.'
    end
  end
  
  
end
