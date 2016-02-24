class TemplateReplacerService < Service

  # Regex to determine whether a word is in template replacement format
  # e.g. [[tenant.name]] or [[day_of_week]]
  TOKEN_REGEX = /(\[\[[^\]]+\]\])/

  # Replace all tokens in a template with their storEDGE data
  def self.replace_replacements template
    template.gsub(TOKEN_REGEX) do |token|
      replacement = StoredgeService.replacement_for token
      puts "Replacing: #{token} --> #{replacement}"
      replacement
    end
  end

  def self.fetch_context_and_attribute token
    naked_token = strip_brackets token
    context, attribute = parse_context_and_attribute(naked_token)
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
    naked_token.split '.'
  end

  def self.is_token? potential_token
    !(TOKEN_REGEX =~ potential_token).nil?
  end

end
