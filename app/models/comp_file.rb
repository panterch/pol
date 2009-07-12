class CompFile < Comp
  
  has_attached_file :media
  validates_attachment_presence :media

end
