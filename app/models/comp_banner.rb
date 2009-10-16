class CompBanner < Comp

  # comp banner holds several CompImages
  # 
  # make sure to define an comp_image_style 'banner' in pol_cfg, like:
  #
  # pol_cfg.comp_image_styles = {
  # :"banner" => "285>",
  # :"center-box" => "364>"
  # }

  def allowed_children_comps
    return %w( CompImage )
  end


protected 

  
end
