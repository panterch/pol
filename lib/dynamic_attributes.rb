module DynamicAttributes
  def self.included(base)
    dynamic_attributes = pol_cfg.send("#{base.name.downcase}_attributes")
    if base.name == 'Page'
      pol_cfg.location_attributes.each do |attribute, values|
        pol_cfg.comp_locations.each do |location|
          dynamic_attributes["#{attribute}_#{location.tableize.singularize}"] = values
        end
      end
    end
    base.class_eval do
      dynamic_attributes.keys.each do |attribute|
          has_setting(attribute)
      end
    end
  end
end
