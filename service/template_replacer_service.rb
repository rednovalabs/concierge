class TemplateReplacerService < Service

  def self.replace_replacements template
    template.gsub '[[tenant.name]]', 'Dan Miller'
    #todo
  end

  def self.fetch_context_and_attribute token
      naked_token = strip_brackets token
      context, attribute = parse_context_and_attribute naked_token
  end

  private

  # [[tenant.name]] ~> "tenant.name"
  def self.strip_brackets token
    token = token
      .sub(/^\[\[/, '')
      .sub(/\]\]$/, '')
  end

  # "tenant.name" ~> [tenant, name]
  def self.parse_context_and_attribute naked_token
    #todo maybe handle singular attributes, e.g. [[day_of_week]]
    #todo maybe handle nested attributes, e.g. [[tenant.mom.phone_number]]
    token.split '.'
  end

  # "tenant" ~> Tenant (object)
  def self.context_object context, initialization_params = nil
    context.constantize.new initialization_params
  rescue
    nil
  end

end
