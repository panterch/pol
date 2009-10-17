class PolMailer < ActionMailer::Base

  MAIL_RECIPIENT = 'pol@panter.ch'

  def mailable(mailable, params)
    subject    mailable.subject
    recipients mailable.recipients
    from       params[:email]
    template   mailable.template
    body       :params => params
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
