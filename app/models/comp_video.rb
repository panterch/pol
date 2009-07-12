class CompVideo < Comp
  
  has_attached_file :media,
                    :styles => { :normal => '426x300' },
                    :processors => [ :video_thumbnail ]
  validates_attachment_presence :media
  validates_attachment_content_type :media,
      :content_type => ['video/x-flv', 'application/octet-stream' ]

  def pageable?
    true
  end

end
