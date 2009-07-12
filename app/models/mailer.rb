class Mailer < ActionMailer::Base

  def contact(c)
    
    subject    "Kontaktanfrage"
    recipients MAIL_RECIPIENT || I18n.t(:email)
    from       c.from
    
    body       :contact => c
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
