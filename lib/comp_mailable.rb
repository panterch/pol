module CompMailable
    def handle_submit(params)
    # save the received post params as child
    children << CompYaml.new(:page_id => page_id,
                :style_class => style_class, :content => params)
    # send the mail
    PolMailer.deliver_mailable(self, params)
  end

  def subject
    self.class.human_name
  end

  def recipients
    self.string_1
  end

  def template
    self.kind
  end

end
