class CompImage < Comp

  puts 'loading compimage'
  
  has_attached_file :media, :styles => pol_cfg.comp_image_styles

  validates_attachment_presence :media
  validates_attachment_content_type :media,
    :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png']

  def pageable?
    true
  end

end
