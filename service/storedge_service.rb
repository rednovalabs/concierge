class StoredgeService < Service

  # Rather than actually hitting the storEDGE API for the demo, this class will
  # just reach into a mock Tenant object for now.

  # [[tenant.name]] ~> "Dan Miller"
  def self.replacement_for token
    naked_token = strip_brackets token
    context, attribute = parse_context_and_attribute naked_token

    fetch_data context, attribute
  end

  private

  # [[tenant.name]] ~> tenant.name
  def self.strip_brackets token
    token = token
      .sub(/^\[\[/, '')
      .sub(/\]\]$/, '')
  end

  # tenant.name ~> [tenant, name]
  def self.parse_context_and_attribute naked_token
    #todo maybe handle singular attributes, e.g. [[day_of_week]]
    #todo maybe handle nested attributes, e.g. [[tenant.mom.phone_number]]
    token.split '.'
  end

  # [tenant, name] ~> "Dan Miller"
  def fetch_data context, attribute
    context_object(context).send(attribute)
  rescue
    nil
  end

  # tenant ~> Tenant (object)
  def self.context_object context, initialization_params = nil
    context.constantize.new initialization_params
  rescue
    nil
  end

end
