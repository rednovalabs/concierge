class StoredgeService < Service

  # Rather than actually hitting the storEDGE API for the demo, this class will
  # just reach into a mock Tenant object for now.

  # [[tenant.name]] ~> "Dan Miller"
  def self.replacement_for token
    puts "Finding replacement for #{token}"

    context, attribute = TemplateReplacerService.fetch_context_and_attribute token
    puts "Found context, attribute: #{context}, #{attribute}"

    context_object = build_context_object context
    context_object[attribute.to_sym]
  #rescue
  #  nil
  end

  private

  # tenant ~> Tenant (object)
  def self.build_context_object context, initialization_params = nil
    # Create Tenant object for demo, but would otherwise fetch API resource
    puts "Creating context object for #{context.capitalize}"
    Module.const_get(context.capitalize).new initialization_params
  #rescue
  #  nil
  end

end
