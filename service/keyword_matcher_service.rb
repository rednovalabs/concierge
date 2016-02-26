class KeywordMatcherService < Service

  def self.match_to_template message
    full_template = []

    triggers_and_templates.each do |response|
      next unless response["enabled"]

      trigger_regex = regex_trigger_for response["trigger"]
      if !(message.downcase =~ trigger_regex).nil?
        if response["context_restriction"]
          next unless @context == response["context_restriction"]
        end
        @context = response["set_context"]

        full_template << response["template"]
      end
    end

    if full_template.empty?
      # Catchall template
      "Sorry [[tenant.first_name]], but I didn't understand your question. <<what can you do>>"
    else
      full_template.compact.uniq.join ' '
    end
  end

  def self.triggers_and_templates reload: false
    @triggers_and_templates = nil if reload
    @triggers_and_templates ||= begin
      puts "Loading all triggers and templates"
      all_triggers_and_templates = []

      seed_files = Dir[File.dirname(__FILE__) + '/../seed/responses/*.json']
      puts "Found #{seed_files.count} seed files: #{seed_files}"
      seed_files.each do |filename|
        responses_array = load_json_from_file filename
        all_triggers_and_templates.concat(responses_array.compact)
      end

      puts "Loaded #{all_triggers_and_templates.count} triggers and templates"
      all_triggers_and_templates
    end
  end

  def self.context
    #todo per-user
    @context
  end

  private

  def self.regex_trigger_for response
    Regexp.new response
  #rescue
  #//
  end

  def self.load_json_from_file filename
    file = File.read filename
    JSON.parse(file)
  #rescue
  #  {}
  end

end
