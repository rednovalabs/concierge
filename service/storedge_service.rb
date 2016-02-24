class StoredgeService < Service

  # Rather than actually hitting the storEDGE API for the demo, this class will
  # just reach into a mock Tenant object for now.

  # [[tenant.name]] ~> "Dan Miller"
  def self.replacement_for token
    context, attribute = TemplateReplacerService.fetch_context_and_attribute token

    context_object = build_context_object context
    context_object[attribute]
  rescue
    nil
  end

  private

  # tenant ~> Tenant (object)
  def build_context_object context, initialization_params = nil
    # Create Tenant object for demo, but would otherwise fetch API resource
    context.constantize.new initialization_params
  rescue
    nil
  end

end
