class TemplateReplacerService < Service

  def self.replace_replacements template
    template.gsub '[[tenant.name]]', 'Dan Miller'
    #todo
  end

end
