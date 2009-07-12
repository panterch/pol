class CompImage < Comp
  
  has_attached_file :media, :styles => { :'top-box' => "740",
                                         :'bottom-box' => "740",
                                         :'left-box' => "490", 
                                         :'right-box' => "240",
                                         :'gallery-thumbnail' => "75",
                                         :'lightbox-thumbnail' => "115x70#" }

  validates_attachment_presence :media
  validates_attachment_content_type :media,
    :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']

  def pageable?
    true
  end

end
