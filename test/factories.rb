Factory.define :page do |f|
  f.sequence(:title) { |n| "Page #{n}" }
  f.sequence(:permalink) { |n| "page-#{n}" }
  f.desc "Page description"
  f.hidden false
  f.parent nil
end

Factory.define :comp_text do |f|
  f.page :page
  f.parent nil
  #f.type "CompText"
  f.content "Some text for the text component"
  f.style_class "left-box"
  f.sequence(:position) { |n| n }
end

Factory.define :comp_image do |f|
  f.page :page
  f.parent nil
  #f.type "CompImage"
  f.content "Some byline for the image"
  f.media_file_name "kitten.jpg"
  f.media_content_type "image/jpeg"
  f.style_class "left-box"
  f.sequence(:position) { |n| n }
end

Factory.define :comp_video do |f|
  f.page :page
  f.parent nil
  #f.type "CompImage"
  f.content "Some byline for the video"
  f.media_file_name "video.flv"
  f.media_content_type "video/x-flv"
  f.style_class "left-box"
  f.sequence(:position) { |n| n }
end

Factory.define :comp_map do |f|
  f.page :page
  f.parent nil
  #f.type "CompMap"
  f.content "Some help text how to navigate the map"
  f.lat 46.8573738511676
  f.lng 9.5361328125
  f.level 10
  f.style_class "right-box"
  f.sequence(:position) { |n| n }
end

Factory.define :contact do |f|
  f.from 'immo@example.com'
  f.body 'je voudrais acheter votre maison'
end