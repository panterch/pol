class CompMailer < Comp

  def handle_submit(params)
    # save the received post params as child
    children << CompYaml.new(:page_id => page_id,
                :style_class => style_class, :content => params)
    # send the mail
    PolMailer.deliver_contact(params)
  end

  def pageable?
    false
  end

end
